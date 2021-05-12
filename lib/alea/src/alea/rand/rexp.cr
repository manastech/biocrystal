require "../core/czig"
require "../core/cerr"

module Alea
  struct Random(G)
    # Generate a *exp-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`λ^-1`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `scale` is negative or zero.
    def exp(scale = 1.0) : Float64
      __exp64 scale
    end

    # Run-time argument sanitizer for `#exp`.
    private def __exp64(scale : Number) : Float64
      if scale.class < Float
        Alea.sanity_check(scale, :scale, :exp)
      end

      Alea.param_check(scale, :<=, 0.0, :scale, :exp)

      __next_exp64 * scale.to_f64
    end

    # Generate a *exp-distributed*, pseudo-random `Float64`.
    # Unparsed version of `exp`.
    #
    # **@note**:
    # * `scale` is `1.0`.
    def next_exp : Float64
      __next_exp64
    end

    # Generate a *exp-distributed*, pseudo-random `Float64`.
    # Unparsed version of `exp`.
    #
    # **@parameters**:
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`λ^-1`**.
    def next_exp(scale : Float64) : Float64
      __next_exp64 * scale
    end

    # Generate a *exp-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `exp`.
    private def __next_exp64 : Float64
      while true
        r = @prng.next_u64 >> 12
        idx = r & 0xff
        x = r * Core::Exp::W64[idx]
        # this returns 98.9% of the time on 1st try
        r < Core::Exp::K64[idx] && return x
        idx == 0 && return Core::Exp::R64 - Math.log(@prng.next_f64)
        # return from the triangular area
        (Core::Exp::F64[idx - 1] - Core::Exp::F64[idx]) * @prng.next_f64 + \
          Core::Exp::F64[idx] < Math.exp(-x) && return x
      end
    end

    # Generate a *exp-distributed*, pseudo-random `Float32`.
    #
    # **@parameters**:
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`λ^-1`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `scale` is negative or zero.
    def exp32(scale = 1.0f32) : Float32
      __exp32 scale
    end

    # Run-time argument sanitizer for `#exp32`.
    private def __exp32(scale : Number) : Float32
      if scale.class < Float
        Alea.sanity_check(scale, :scale, :exp32)
      end

      Alea.param_check(scale, :<=, 0.0, :scale, :exp32)

      __next_exp32 * scale.to_f32
    end

    # Generate a *exp-distributed*, pseudo-random `Float32`.
    # Unparsed version of `exp32`.
    #
    # **@note**:
    # * `scale` is `1.0`.
    def next_exp32 : Float32
      __next_exp32
    end

    # Generate a *exp-distributed*, pseudo-random `Float32`.
    # Unparsed version of `exp32`.
    #
    # **@parameters**:
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`λ^-1`**.
    def next_exp32(scale : Float32) : Float32
      __next_exp32 * scale
    end

    # Generate a *exp-distributed*, pseudo-random `Float32`.
    # Unwrapped version of `exp32`.
    private def __next_exp32 : Float32
      while true
        r = @prng.next_u32 >> 1
        idx = r & 0xff
        r >>= 8
        x = r * Core::Exp::W32[idx]
        # this returns 98.9% of the time on 1st try
        r < Core::Exp::K32[idx] && return x
        idx == 0 && return Core::Exp::R32 - Math.log(@prng.next_f32)
        # return from the triangular area
        (Core::Exp::F32[idx - 1] - Core::Exp::F32[idx]) * @prng.next_f32 + \
          Core::Exp::F32[idx] < Math.exp(-x) && return x
      end
    end
  end
end
