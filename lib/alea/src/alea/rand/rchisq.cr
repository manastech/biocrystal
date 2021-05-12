require "./rgamma"

module Alea
  struct Random(G)
    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`k`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def chisq(df)
      __chisq64 df
    end

    # Run-time argument sanitizer for `#chisq`.
    private def __chisq64(df : Number) : Float64
      if df.class < Float
        Alea.sanity_check(df, :df, :chisq)
      end

      Alea.param_check(df, :<=, 0.0, :df, :chisq)

      __next_chisq64 df.to_f64
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    # Unparsed version of `chisq`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`k`**.
    def next_chisq(df : Float64) : Float64
      __next_chisq64 df
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `chisq`.
    private def __next_chisq64(df : Float64) : Float64
      next_gamma(df / 2.0) * 2.0
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float32`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`k`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def chisq32(df)
      __chisq32 df
    end

    # Run-time argument sanitizer for `#chisq32`.
    private def __chisq32(df : Number) : Float32
      if df.class < Float
        Alea.sanity_check(df, :df, :chisq32)
      end

      Alea.param_check(df, :<=, 0.0, :df, :chisq32)

      __next_chisq32 df.to_f32
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float32`.
    # Unparsed version of `chisq32`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`k`**.
    def next_chisq32(df : Float32) : Float32
      __next_chisq32 df
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float32`.
    # Unwrapped version of `chisq32`.
    private def __next_chisq32(df : Float32) : Float32
      next_gamma32(df / 2.0f32) * 2.0f32
    end
  end
end
