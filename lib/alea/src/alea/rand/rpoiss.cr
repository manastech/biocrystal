require "../core/cpois"
require "../core/cerr"

module Alea
  struct Random(G)
    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    #
    # **@parameters**:
    # * `lam`: separation parameter of the distribution;
    #   usually mentioned as **`λ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `lam` is negative or zero.
    def poisson(lam = 1.0)
      __poisson64 lam
    end

    # Run-time argument sanitizer for `#poisson`.
    private def __poisson64(lam : Number) : Int64
      if lam.class < Float
        Alea.sanity_check(lam, :lam, :poisson)
      end

      Alea.param_check(lam, :<=, 0.0, :lam, :poisson)

      __next_poisson64 lam.to_f64
    end

    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    # Unparsed version of `#poisson`.
    #
    # **@notes**:
    # * `lam` is `1.0`.
    def next_poisson : Int64
      Alea::Core.poisson_mult 1.0, @prng
    end

    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    # Unparsed version of `#poisson`.
    #
    # **@parameters**:
    # * `lam`: separation parameter of the distribution;
    #   usually mentioned as **`λ`**.
    def next_poisson(lam : Float64) : Int64
      __next_poisson64 lam
    end

    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    # Unwrapped version of `#poisson`.
    private def __next_poisson64(lam : Float64) : Int64
      (lam >= 10.0) && return Alea::Core.poisson_ptrs lam, @prng
      (lam == 0.0) && return 0i64
      Alea::Core.poisson_mult lam, @prng
    end
  end
end
