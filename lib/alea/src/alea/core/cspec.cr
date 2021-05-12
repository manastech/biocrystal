module Alea::Core::SpecFun
  # Iteration limits within which `Alea::NoConvergeError` is not raised
  MAX_ITER = 10_000

  # Single precision tolerance
  EPSILON_32 = 1.0e-07

  # Double precision tolerance
  EPSILON_64 = 1.0e-15

  # Copyright (c) 2016, Jernej Kovacic
  # Licensed under the MIT "Expat" License.
  #
  # See LICENSE.md for more details.
  #
  # Note: code in this file is based on the C++ library "Math", available at:
  # https://github.com/jkovacic/math and
  # https://github.com/jkovacic/math/blob/master/lib/specfun/SpecFunGeneric.cpp

  # Implementation of the Gamma Special functions (incomplete, incomplete regularized).
  module Gamma
    # Estimates the Incomplete Gamma Function
    #
    # When `x > (a+1)`, the upper gamma function can be evaluated as
    #
    # ```text
    #                 -x    a
    #                e   * x
    #   G(a,x) ~= --------------
    #                cf(a,x)
    # ```
    # where `cf(a,x)` is the continued fraction defined above, its coefficients
    # `a(i)` and `b(i)` are implemented in `#inc_gamma_ctdfr_proc`.
    #
    # When `x < (a+1)`, it is more convenient to apply the following Taylor series
    # that evaluates the lower incomplete gamma function:
    #
    # ```text
    #                          inf
    #                         -----
    #              -x    a    \        G(a)       i
    #   g(a,x) ~= e   * x  *   >    ---------- * x
    #                         /      G(a+1+i)
    #                         -----
    #                          i=0
    # ```
    #
    # Applying the following property of the gamma function:
    #
    # ```text
    #   G(a+1) = a * G(a)
    # ```
    #
    # The Taylor series above can be further simplified to:
    #
    # ```text
    #                          inf
    #                         -----              i
    #              -x    a    \                 x
    #   g(a,x) ~= e   * x  *   >    -------------------------
    #                         /      a * (a+1) * ... * (a+i)
    #                         -----
    #                          i=0
    # ```
    #
    # Once either a lower or an upper incomplete gamma function is evaluated,
    # the other value may be quickly obtained by applying the following
    # property of the incomplete gamma function:
    #
    # ```text
    #   G(a,x) + g(a,x) = G(a)
    # ```
    #
    # **@parameters**:
    # * `a`: parameter of the Incomplete Gamma function.
    # * `x`: the upper integration limit.
    # * `uorl`: symbol to request the `:upper` or `:lower` inc. gamma function.
    #
    # **@exceptions**:
    # * `Alea::NoConvergeError` if no convergence occurs within `MAX_ITER` iterations.
    def self.incomplete(a : Float64, x : Float64, uorl : Symbol) : Float64
      if x > (a + 1.0)
        # Compute the Upper Incomplete Gamma function
        ginc = self.upper64(a, x)

        if uorl == :lower
          ginc = Math.gamma(a) - ginc
        end
      else
        # Compute the Lower Incomplete Gamma function
        ginc = self.lower64(a, x)

        if uorl == :upper
          ginc = Math.gamma(a) - ginc
        end
      end
      ginc
    end

    # :ditto:
    def self.incomplete(a : Float32, x : Float32, uorl : Symbol) : Float32
      if x > (a + 1.0f32)
        # Compute the Upper Incomplete Gamma function
        ginc = self.upper32(a, x)

        if uorl == :lower
          ginc = Math.gamma(a) - ginc
        end
      else
        # Compute the Lower Incomplete Gamma function
        ginc = self.lower32(a, x)

        if uorl == :upper
          ginc = Math.gamma(a) - ginc
        end
      end
      ginc
    end

    # Estimates the Incomplete Regularized Gamma function in double precision.
    #
    # **@parameters**:
    # * `a`: parameter of the Incomplete Gamma function.
    # * `x`: the upper integration limit.
    # * `uorl`: symbol to request the `:upper` or `:lower` inc. reg. gamma function.
    #
    # **@references**:
    # * `Alea::Core::SpecFun::Gamma.incomplete`
    #
    # **@exceptions**:
    # * `Alea::NoConvergeError` if no convergence occurs within `MAX_ITER` iterations.
    def self.incomplete_reg(a : Float64, x : Float64, uorl : Symbol) : Float64
      self.incomplete(a, x, uorl) / Math.gamma(a)
    end

    # Estimates the Incomplete Regularized Gamma function in single precision.
    #
    # **@parameters**:
    # * `a`: parameter of the Incomplete Gamma function.
    # * `x`: the upper integration limit.
    # * `uorl`: symbol to request the `:upper` or `:lower` inc. reg. gamma function.
    #
    # **@references**:
    # * `Alea::Core::SpecFun::Gamma.incomplete`
    #
    # **@exceptions**:
    # * `Alea::NoConvergeError` if no convergence occurs within `MAX_ITER` iterations.
    def self.incomplete_reg(a : Float32, x : Float32, uorl : Symbol) : Float32
      self.incomplete(a, x, uorl) / Math.gamma(a)
    end

    {% for s in ["32".id, "64".id] %}
      # Returns a Tuple containing 2 pointers to function (procs) used to manipulate
      # indexes to calculate the i-ths coefficients in continued fractions.
      #
      # ```text
      #                            1*(1-a)
      #   cf = (x-a+1) - ---------------------------
      #                                  2*(2-a)
      #                    (x-a+3) - ---------------
      #                                (x-a+5) - ...
      # ```
      private def self.continued_fractions_proc{{s}}(a : Float{{s}}, x : Float{{s}}) : Tuple(Proc(Int32, Float{{s}}), Proc(Int32, Float{{s}}))
        {
          ->(i : Int32) { (-i) * (i - a) },
          ->(i : Int32) { x - a + 1.0_f{{s}} + i + i },
        }
      end

      # The Lentz's algorithm (modified by I. J. Thompson and A. R. Barnett)
      # is applied to evaluate the continued fraction. The algorithm is
      # presented in detail in:
      #
      #   William H. Press, Saul A. Teukolsky, William T. Vetterling, Brian P. Flannery
      #   Numerical Recipes, The Art of Scientific Computing, 3rd Edition,
      #   Cambridge University Press, 2007
      #
      #   https://books.google.com/books?id=1aAOdzK3FegC&lpg=PA207&ots=3jNoK9Crpj&pg=PA208#v=onepage&f=false
      #
      # The procedure of the algorithm is as follows:
      #
      # - f0 = b0, if b0==0 then f0 = eps
      # - C0 = f0
      # - D0 = 0
      # - for j = 1, 2, 3, ...
      #   -- Dj = bj + aj * D_j-1, if Dj==0 then Dj = eps
      #   -- Cj = bj + aj / C_j-1, if Cj==0 then Cj = eps
      #   -- Dj = 1 / Dj
      #   -- Delta_j = Cj * Dj
      #   -- fj = f_j-1 * Delta_j
      #   -- if abs(Delta_j-1) < TOL then exit for loop
      # - return fj
      #
      # Raises `Alea::NoConvergeError` if no convergence has occurred within *MAX_ITER* iterations.
      private def self.continued_fractions_eval{{s}}(fa : Proc(Int32, Float{{s}}), fb : Proc(Int32, Float{{s}})) : Float{{s}}
        fi = fb.call(0)

        # adjust f0 to eps if necessary
        if fi.abs < Float{{s}}::EPSILON
          fi = Float{{s}}::EPSILON
        end

        ci = fi
        di = 0.0_f{{s}}
        df = 0.0_f{{s}}
        itr = 1

        while (df - 1.0_f{{s}}).abs > EPSILON_{{s}} && itr < MAX_ITER
          ai = fa.call itr
          bi = fb.call itr

          di = bi + ai * di
          # adjust di to eps if necessary
          if di.abs < Float{{s}}::EPSILON
            di = Float{{s}}::EPSILON
          end

          ci = bi + ai / ci
          # adjust di to eps if necessary
          if ci.abs < Float{{s}}::EPSILON
            ci = Float{{s}}::EPSILON
          end

          di = 1.0_f{{s}} / di
          df = ci * di
          fi = df * fi
          itr += 1
        end

        # Check if expansion has converged
        if itr >= MAX_ITER
          raise Alea::NoConvergeError.new "Iteration out of bounds"
        end

        fi
      end

      # Inner, unparsed, estimation of the Upper Inc. Gamma function
      private def self.upper{{s}}(a : Float{{s}}, x : Float{{s}}) : Float{{s}}
        # First term of the fraction
        ginc = Math.exp(-x) * (x ** a)
        # Setting up the procs with values
        fa, fb = self.continued_fractions_proc{{s}}(a, x)
        # Link the procs to evaluator
        ginc / self.continued_fractions_eval{{s}}(fa, fb)
      end

      # Inner, unparsed, estimation of the Lower Inc. Gamma function
      private def self.lower{{s}}(a : Float{{s}}, x : Float{{s}}) : Float{{s}}
        # First term of the fraction
        ginc = Math.exp(-x) * (x ** a) / a
        term = ginc
        ai = a
        itr = 1
        # Taylor series
        while term.abs > EPSILON_{{s}} && itr < MAX_ITER
          ai += 1.0_f{{s}}
          term *= (x / ai)
          ginc += term
          itr += 1
        end
        # Check if series has converged
        if itr >= MAX_ITER
          raise Alea::NoConvergeError.new "Iteration out of bounds"
        end
        ginc
      end
    {% end %}
  end
end
