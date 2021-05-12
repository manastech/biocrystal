require "./rgamma"

module Alea
  struct Random(G)
    # Generate a *beta-distributed*, pseudo-random `Float64` in range `[0, 1)`.
    #
    # **@note**: named arguments are mandatory to prevent ambiguity.
    #
    # **@parameters**:
    # * `a`: shape parameter of the distribution;
    #   usually mentioned as **`α`**.
    # * `b`: shape parameter of the distribution;
    #   usually mentioned as **`β`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if any of `a` or `b` is negative or zero.
    def beta(*, a, b)
      __beta64 a, b
    end

    # Run-time argument sanitizer for `#beta`.
    private def __beta64(a : Number, b : Number) : Float64
      if a.class < Float
        Alea.sanity_check(a, :a, :beta)
      end

      if b.class < Float
        Alea.sanity_check(b, :b, :beta)
      end

      Alea.param_check(a, :<=, 0.0, :a, :beta)
      Alea.param_check(b, :<=, 0.0, :b, :beta)

      __next_beta64 a.to_f64, b.to_f64
    end

    # Generate a *beta-distributed*, pseudo-random `Float64` in range `[0, 1)`.
    # Unparsed version of `#beta`.
    #
    # **@note**: named arguments are mandatory to prevent ambiguity.
    #
    # **@parameters**:
    # * `a`: shape parameter of the distribution;
    #   usually mentioned as **`α`**.
    # * `b`: shape parameter of the distribution;
    #   usually mentioned as **`β`**.
    def next_beta(*, a : Float64, b : Float64) : Float64
      __next_beta64 a, b
    end

    # Generate a *beta-distributed*, pseudo-random `Float64` in range `[0, 1)`.
    # Unwrapped version of `#beta`.
    private def __next_beta64(a : Float64, b : Float64) : Float64
      if a <= 1.0 && b <= 1.0
        while true
          u = @prng.next_f64
          v = @prng.next_f64
          x = u ** (1.0 / a)
          y = v ** (1.0 / b)
          if (x + y) <= 1.0
            (x + y) > 0.0 && return x / (x + y)
            logx = Math.log(u) / a
            logy = Math.log(v) / b
            logm = logx > logy ? logx : logy
            logx -= logm
            logy -= logm
            expx = Math.exp(logx)
            expy = Math.exp(logy)
            return Math.exp(logx - Math.log(expx + expy))
          end
        end
      else
        ga = next_gamma(a)
        gb = next_gamma(b)
        ga / (ga + gb)
      end
    end

    # Generate a *beta-distributed*, pseudo-random `Float32` in range `[0, 1)`.
    #
    # **@note**: named arguments are mandatory to prevent ambiguity.
    #
    # **@parameters**:
    # * `a`: shape parameter of the distribution;
    #   usually mentioned as **`α`**.
    # * `b`: shape parameter of the distribution;
    #   usually mentioned as **`β`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if any of `a` or `b` is negative or zero.
    def beta32(*, a, b)
      __beta32 a, b
    end

    # Run-time argument sanitizer for `#beta32`.
    private def __beta32(a : Number, b : Number) : Float32
      if a.class < Float
        Alea.sanity_check(a, :a, :beta32)
      end

      if b.class < Float
        Alea.sanity_check(b, :b, :beta32)
      end

      Alea.param_check(a, :<=, 0.0, :a, :beta32)
      Alea.param_check(b, :<=, 0.0, :b, :beta32)

      __next_beta32 a.to_f32, b.to_f32
    end

    # Generate a *beta-distributed*, pseudo-random `Float32` in range `[0, 1)`.
    # Unparsed version of `#beta32`.
    #
    # **@note**: named arguments are mandatory to prevent ambiguity.
    #
    # **@parameters**:
    # * `a`: shape parameter of the distribution;
    #   usually mentioned as **`α`**.
    # * `b`: shape parameter of the distribution;
    #   usually mentioned as **`β`**.
    def next_beta32(*, a : Float32, b : Float32) : Float32
      __next_beta32 a, b
    end

    # Generate a *beta-distributed*, pseudo-random `Float32` in range `[0, 1)`.
    # Unwrapped version of `#beta32`.
    private def __next_beta32(a : Float32, b : Float32) : Float32
      if a <= 1.0f32 && b <= 1.0f32
        while true
          u = @prng.next_f32
          v = @prng.next_f32
          x = u ** (1.0f32 / a)
          y = v ** (1.0f32 / b)
          if (x + y) <= 1.0f32
            (x + y) > 0.0f32 && return x / (x + y)
            logx = Math.log(u) / a
            logy = Math.log(v) / b
            logm = logx > logy ? logx : logy
            logx -= logm
            logy -= logm
            expx = Math.exp(logx)
            expy = Math.exp(logy)
            return Math.exp(logx - Math.log(expx + expy))
          end
        end
      else
        ga = next_gamma32(a)
        gb = next_gamma32(b)
        ga / (ga + gb)
      end
    end
  end
end
