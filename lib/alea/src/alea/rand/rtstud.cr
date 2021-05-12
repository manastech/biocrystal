require "../core/cerr"

module Alea
  struct Random(G)
    # Generate a *t-student-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`n`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def t(df)
      __t64 df
    end

    # Run-time argument sanitizer for `#t`.
    private def __t64(df : Number) : Float64
      if df.class < Float
        Alea.sanity_check(df, :df, :t)
      end

      Alea.param_check(df, :<=, 0.0, :df, :t)

      __next_t64 df.to_f64
    end

    # Generate a *t-student-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#t`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`n`**.
    def next_t(df : Float64) : Float64
      __next_t64 df
    end

    # Generate a *t-student-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `#t`.
    private def __next_t64(df : Float64) : Float64
      hlf = df / 2.0
      num = next_normal
      den = next_gamma hlf
      Math.sqrt(hlf) * num / Math.sqrt(den)
    end

    # Generate a *t-student-distributed*, pseudo-random `Float32`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`n`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def t32(df)
      __t32 df
    end

    # Run-time argument sanitizer for `#t32`.
    private def __t32(df : Number) : Float32
      if df.class < Float
        Alea.sanity_check(df, :df, :t32)
      end

      Alea.param_check(df, :<=, 0.0, :df, :t32)

      __next_t32 df.to_f32
    end

    # Generate a *t-student-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#t32`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`n`**.
    def next_t32(df : Float32) : Float32
      __next_t32 df
    end

    # Generate a *t-student-distributed*, pseudo-random `Float32`.
    # Unwrapped version of `#t32`.
    private def __next_t32(df : Float32) : Float32
      hlf = df / 2.0f32
      num = next_normal32
      den = next_gamma32 hlf
      Math.sqrt(hlf) * num / Math.sqrt(den)
    end
  end
end
