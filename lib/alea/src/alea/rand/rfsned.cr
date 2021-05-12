require "../core/cerr"
require "./rchisq"

module Alea
  struct Random(G)
    # Generate a *f-snedecor-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `df1`: degrees of freedom of the underlying chi-square distribution,
    #		numerator side; usually mentioned as **`m`**.
    # * `df2`: degrees of freedom of the underlying chi-square distribution,
    #		denominator side; usually mentioned as **`n`**.
    #
    # **@note**: due to homonymy with float methods, the unparsed method
    #		is indentified with `next_fs`.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def f(df1, df2)
      __f64 df1, df2
    end

    # Run-time argument sanitizer for `#f`.
    private def __f64(df1 : Number, df2 : Number) : Float64
      if df1.class < Float
        Alea.sanity_check(df1, :df1, :f)
      end

      if df2.class < Float
        Alea.sanity_check(df2, :df2, :f)
      end

      Alea.param_check(df1, :<=, 0.0, :df1, :f)
      Alea.param_check(df2, :<=, 0.0, :df2, :f)

      __next_fs64 df1.to_f64, df2.to_f64
    end

    # Generate a *f-snedecor-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#f`.
    #
    # **@parameters**:
    # * `df1`: degrees of freedom of the underlying chi-square distribution,
    #		numerator side; usually mentioned as **`m`**.
    # * `df2`: degrees of freedom of the underlying chi-square distribution,
    #		denominator side; usually mentioned as **`n`**.
    def next_fs(df1 : Float64, df2 : Float64) : Float64
      __next_fs64 df1, df2
    end

    # Generate a *f-snedecor-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `#f`.
    private def __next_fs64(df1 : Float64, df2 : Float64) : Float64
      (next_chisq(df1) * df2) / (next_chisq(df2) * df1)
    end

    # Generate a *f-snedecor-distributed*, pseudo-random `Float32`.
    #
    # **@parameters**:
    # * `df1`: degrees of freedom of the underlying chi-square distribution,
    #		numerator side; usually mentioned as **`m`**.
    # * `df2`: degrees of freedom of the underlying chi-square distribution,
    #		denominator side; usually mentioned as **`n`**.
    #
    # **@note**: due to homonymy with float methods, the unparsed method
    #		is indentified with `next_fs32`.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def f32(df1, df2)
      __f32 df1, df2
    end

    # Run-time argument sanitizer for `#f32`.
    private def __f32(df1 : Number, df2 : Number) : Float32
      if df1.class < Float
        Alea.sanity_check(df1, :df1, :f32)
      end

      if df2.class < Float
        Alea.sanity_check(df2, :df2, :f32)
      end

      Alea.param_check(df1, :<=, 0.0, :df1, :f32)
      Alea.param_check(df2, :<=, 0.0, :df2, :f32)

      __next_fs32 df1.to_f32, df2.to_f32
    end

    # Generate a *f-snedecor-distributed*, pseudo-random `Float32`.
    # Unparsed version of `#f32`.
    #
    # **@parameters**:
    # * `df1`: degrees of freedom of the underlying chi-square distribution,
    #		numerator side; usually mentioned as **`m`**.
    # * `df2`: degrees of freedom of the underlying chi-square distribution,
    #		denominator side; usually mentioned as **`n`**.
    def next_fs32(df1 : Float32, df2 : Float32) : Float32
      __next_fs32 df1, df2
    end

    # Generate a *f-snedecor-distributed*, pseudo-random `Float32`.
    # Unwrapped version of `#f32`.
    private def __next_fs32(df1 : Float32, df2 : Float32) : Float32
      (next_chisq32(df1) * df2) / (next_chisq32(df2) * df1)
    end
  end
end
