require "../core/czig"
require "../core/cerr"

module Alea
  struct Random(G)
    # Generate a *normal-distributed*, pseudo-random `Float32`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the distribution;
    #   usually mentioned as **`σ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `sigma` is negative or zero.
    def normal32(loc = 0.0, sigma = 1.0) : Float32
      __normal32 loc, sigma
    end

    # Run-time argument sanitizer for `#normal32`.
    private def __normal32(loc : Number, sigma : Number) : Float32
      if loc.class < Float
        Alea.sanity_check(loc, :loc, :normal32)
      end

      if sigma.class < Float
        Alea.sanity_check(sigma, :sigma, :normal32)
      end

      Alea.param_check(sigma, :<=, 0.0, :sigma, :normal32)

      __next_normal32 * sigma.to_f32 + loc.to_f32
    end

    # Generate a *normal-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the distribution;
    #   usually mentioned as **`σ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `sigma` is negative or zero.
    def normal(loc = 0.0, sigma = 1.0)
      __normal64 loc, sigma
    end

    # Run-time argument sanitizer for `#normal`.
    private def __normal64(loc : Number, sigma : Number) : Float64
      if loc.class < Float
        Alea.sanity_check(loc, :loc, :normal)
      end

      if sigma.class < Float
        Alea.sanity_check(sigma, :sigma, :normal)
      end

      Alea.param_check(sigma, :<=, 0.0, :sigma, :normal)

      __next_normal64 * sigma.to_f64 + loc.to_f64
    end

    # Generate a *normal-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#normal32`.
    #
    # **@notes**:
    # * `loc` is `0.0`.
    # * `sigma` is `1.0`.
    def next_normal32 : Float32
      __next_normal32
    end

    # Generate a *normal-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#normal32`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    #
    # **@notes**:
    # * `sigma` is `1.0`.
    def next_normal32(loc : Float32) : Float32
      __next_normal32 + loc
    end

    # Generate a *normal-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#normal32`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the distribution;
    #   usually mentioned as **`σ`**.
    def next_normal32(loc : Float32, sigma : Float32) : Float32
      __next_normal32 * sigma + loc
    end

    # Generate a *normal-distributed*, pseudo-random `Float32`.
    # Unwrapped version of `#normal32`.
    private def __next_normal32 : Float32
      while true
        r = @prng.next_u32
        rabs = Int32.new (r >> 9)
        idx = r & 0xff
        x = ((r >> 8) & 0x1 == 1 ? -rabs : rabs) * Core::Normal::W32[idx]
        # this returns 99.3% of the time on 1st try
        rabs < Core::Normal::K32[idx] && return x
        if idx == 0
          while true
            xx = -Core::Normal::RINV32 * Math.log(1.0f32 - @prng.next_f32)
            yy = -Math.log(1.0f32 - @prng.next_f32)
            (yy + yy > xx * xx) && return (rabs >> 8) & 0x1 == 1 ? -Core::Normal::R32 - xx : Core::Normal::R32 + xx
          end
        else
          # return from the triangular area
          (Core::Normal::F32[idx - 1] - Core::Normal::F32[idx]) * @prng.next_f32 + \
            Core::Normal::F32[idx] < Math.exp(-0.5f32 * x * x) && return x
        end
      end
    end

    # Generate a *normal-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#normal`.
    #
    # **@notes**:
    # * `loc` is `0.0`.
    # * `sigma` is `1.0`.
    def next_normal : Float64
      __next_normal64
    end

    # Generate a *normal-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#normal`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    #
    # **@notes**:
    # * `sigma` is `1.0`.
    def next_normal(loc : Float64) : Float64
      __next_normal64 + loc
    end

    # Generate a *normal-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#normal`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the distribution;
    #   usually mentioned as **`σ`**.
    def next_normal(loc : Float64, sigma : Float64) : Float64
      __next_normal64 * sigma + loc
    end

    # Generate a *normal-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `#normal`.
    private def __next_normal64 : Float64
      while true
        r = @prng.next_u64 >> 12
        rabs = Int64.new(r >> 1)
        idx = rabs & 0xff
        x = (r & 0x1 == 1 ? -rabs : rabs) * Core::Normal::W64[idx]
        # this returns 99.3% of the time on 1st try
        rabs < Core::Normal::K64[idx] && return x
        if idx == 0
          while true
            xx = -Core::Normal::RINV64 * Math.log(@prng.next_f64)
            yy = -Math.log(@prng.next_f64)
            (yy + yy > xx * xx) && return (rabs >> 8) & 0x1 == 1 ? -Core::Normal::R64 - xx : Core::Normal::R64 + xx
          end
        else
          # return from the triangular area
          (Core::Normal::F64[idx - 1] - Core::Normal::F64[idx]) * @prng.next_f64 + \
            Core::Normal::F64[idx] < Math.exp(-0.5 * x * x) && return x
        end
      end
    end
  end
end
