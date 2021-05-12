require "../core/cerr"

module Alea
  struct Random(G)
    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `scale` is negative or zero.
    def laplace(loc = 0.0, scale = 1.0)
      __laplace64 loc, scale
    end

    # Run-time argument sanitizer for `#laplace`.
    private def __laplace64(loc : Number, scale : Number) : Float64
      if loc.class < Float
        Alea.sanity_check(loc, :loc, :laplace)
      end

      if scale.class < Float
        Alea.sanity_check(scale, :scale, :laplace)
      end

      Alea.param_check(scale, :<=, 0.0, :scale, :laplace)

      __next_laplace64 * scale.to_f64 + loc.to_f64
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unparsed version of `laplace`.
    #
    # **@notes**:
    # * `loc` is `0.0`.
    # * `scale` is `1.0`.
    def next_laplace : Float64
      __next_laplace64
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unparsed version of `laplace`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    #
    # **@notes**:
    # * `scale` is `1.0`.
    def next_laplace(loc : Float64) : Float64
      __next_laplace64 + loc
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unparsed version of `laplace`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`b`**.
    def next_laplace(loc : Float64, scale : Float64) : Float64
      __next_laplace64 * scale + loc
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `laplace`.
    private def __next_laplace64 : Float64
      while true
        u = @prng.next_f64
        u >= 0.5 && return -Math.log(2.0 - u - u)
        u > 0.0 && return Math.log(u + u)
        # Reject u == 0.0
      end
    end

    # Generate a *laplace-distributed*, pseudo-random `Float32`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `scale` is negative or zero.
    def laplace32(loc = 0.0f32, scale = 1.0f32)
      __laplace32 loc, scale
    end

    # Run-time argument sanitizer for `#laplace32`.
    private def __laplace32(loc : Number, scale : Number) : Float32
      if loc.class < Float
        Alea.sanity_check(loc, :loc, :laplace32)
      end

      if scale.class < Float
        Alea.sanity_check(scale, :scale, :laplace32)
      end

      Alea.param_check(scale, :<=, 0.0, :scale, :laplace32)

      __next_laplace32 * scale.to_f32 + loc.to_f32
    end

    # Generate a *laplace-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#laplace32`.
    #
    # **@notes**:
    # * `loc` is `0.0`.
    # * `scale` is `1.0`.
    def next_laplace32 : Float32
      __next_laplace32
    end

    # Generate a *laplace-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#laplace32`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    #
    # **@notes**:
    # * `scale` is `1.0`.
    def next_laplace32(loc : Float32) : Float32
      __next_laplace32 + loc
    end

    # Generate a *laplace-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#laplace32`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`b`**.
    def next_laplace32(loc : Float32, scale : Float32) : Float32
      __next_laplace32 * scale + loc
    end

    # Generate a *laplace-distributed*, pseudo-random `Float32`.
    # Unwrapped version of `#laplace32`.
    private def __next_laplace32 : Float32
      while true
        u = @prng.next_f32
        u >= 0.5f32 && return -Math.log(2.0f32 - u - u)
        u > 0.0f32 && return Math.log(u + u)
        # Reject u == 0.0
      end
    end
  end
end
