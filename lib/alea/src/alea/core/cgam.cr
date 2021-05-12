module Alea::Core
  # Iteration limit within which `Alea::NoConvergeError` is not raised
  SPECFUN_ITMAX = 1_000

  # Single precision tolerance
  SPECFUN_EPS32 = 1.0e-06

  # Double precision tolerance
  SPECFUN_EPS64 = 1.0e-15

  # Copyright (c) 2016, Jernej Kovacic
  # Licensed under the MIT "Expat" License.
  #
  # See LICENSE.md for more details.
  #
  # Note: code in this file is based on the C++ library "Math", available at:
  # https://github.com/jkovacic/math and
  # https://github.com/jkovacic/math/blob/master/lib/specfun/SpecFunGeneric.cpp

  # :nodoc:
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
  def self.inc_gamma_ctdfr_proc(a, x)
    {
      ->(i : Int32) { (-i) * (i - a) },
      ->(i : Int32) { x - a + 1.0 + i + i },
    }
  end

  # :nodoc:
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
  # Raises `Alea::NoConvergeError` if no convergence has occurred within *SPECFUN_ITMAX* iterations.
  def self.inc_gamma_ctdfr_eval(fa, fb)
    fi = fb.call(0)

    # adjust f0 to eps if necessary
    if fi.abs < Float64::EPSILON
      fi = Float64::EPSILON
    end

    ci = fi
    di = 0.0
    df = 0.0
    itr = 1

    while (df - 1.0).abs > SPECFUN_EPS64 && itr < SPECFUN_ITMAX
      ai = fa.call itr
      bi = fb.call itr

      di = bi + ai * di
      # adjust di to eps if necessary
      if di.abs < Float64::EPSILON
        di = Float64::EPSILON
      end

      ci = bi + ai / ci
      # adjust di to eps if necessary
      if ci.abs < Float64::EPSILON
        ci = Float64::EPSILON
      end

      di = 1.0 / di
      df = ci * di
      fi = df * fi
      itr += 1
    end

    # Check if expansion has converged
    if itr >= SPECFUN_ITMAX
      raise Alea::NoConvergeError.new "Iteration out of bounds"
    end

    fi
  end

  # Estimate the Incomplete Gamma Function
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
  # * `Alea::NoConvergeError` if no convergence occurs within `SPECFUN_ITMAX` iterations.
  def self.inc_gamma(a, x, uorl)
    if x > (a + 1.0)
      # Compute the upper incomplete gamma function
      ginc = self.inc_gamma_upper(a, x)

      if uorl == :lower
        ginc = Math.gamma(a) - ginc
      end
    else
      # Compute the lower incomplete gamma function
      ginc = self.inc_gamma_lower(a, x)

      if uorl == :upper
        ginc = Math.gamma(a) - ginc
      end
    end
    ginc
  end

  # :nodoc:
  # Inner, unparsed, estimation of the upper inc. gamma function
  def self.inc_gamma_upper(a, x)
    # First term of the fraction
    ginc = Math.exp(-x) * (x ** a)
    # Setting up the procs with values
    fa, fb = self.inc_gamma_ctdfr_proc(a, x)
    # Link the procs to evaluator
    ginc / self.inc_gamma_ctdfr_eval(fa, fb)
  end

  # :nodoc:
  # Inner, unparsed, estimation of the lower inc. gamma function
  def self.inc_gamma_lower(a, x)
    # First term of the fraction
    ginc = Math.exp(-x) * (x ** a) / a
    term = ginc
    ai = a
    itr = 1
    # Taylor series
    while term.abs > SPECFUN_EPS64 && itr < SPECFUN_ITMAX
      ai += 1.0
      term *= (x / ai)
      ginc += term
      itr += 1
    end
    # Check if series has converged
    if itr >= SPECFUN_ITMAX
      raise Alea::NoConvergeError.new "Iteration out of bounds"
    end
    ginc
  end

  # Estimate the Incomplete Regularized Gamma function.
  #
  # **@parameters**:
  # * `a`: parameter of the Incomplete Gamma function.
  # * `x`: the upper integration limit.
  # * `uorl`: symbol to request the `:upper` or `:lower` inc. reg. gamma function.
  #
  # **@references**:
  # * `Alea::Core.inc_gamma`
  #
  # **@exceptions**:
  # * `Alea::NoConvergeError` if no convergence occurs within `SPECFUN_ITMAX` iterations.
  def self.inc_gamma_regular(a, x, uorl)
    self.inc_gamma(a, x, uorl) / Math.gamma(a)
  end

  # Estimate the Incomplete Regular Upper Gamma function.
  #
  # **@parameters**:
  # * `a`: parameter of the Incomplete Gamma function.
  # * `x`: the upper integration limit.
  #
  # **@references**:
  # * `Alea::Core.inc_gamma`
  #
  # **@exceptions**:
  # * `Alea::NoConvergeError` if no convergence occurs within `SPECFUN_ITMAX` iterations.
  def self.incg_regular_upper(a, x)
    self.inc_gamma(a, x, upper: true) / Math.gamma(a)
  end

  # Estimate the Incomplete Regular Lower Gamma function.
  #
  # **@parameters**:
  # * `a`: parameter of the Incomplete Gamma function.
  # * `x`: the upper integration limit.
  #
  # **@references**:
  # * `Alea::Core.inc_gamma`
  #
  # **@exceptions**:
  # * `Alea::NoConvergeError` if no convergence occurs within `SPECFUN_ITMAX` iterations.
  def self.incg_regular_lower(a, x)
    self.inc_gamma(a, x, upper: false) / Math.gamma(a)
  end
end
