require "../core/cspec"

module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `df`: degrees of freedom of the distribution;
  #   usually mentioned as **`k`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `df` is negative or zero.
  def self.chisq(x, df) : Float64
    __chisq64 x, df
  end

  # Run-time argument sanitizer for `#chisq`.
  private def self.__chisq64(x : Number, df : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :chisq)
    end

    if df.class < Float
      Alea.sanity_check(df, :df, :chisq)
    end

    Alea.param_check(df, :<=, 0.0, :df, :chisq)

    __cdf_chisq64 x.to_f64, df.to_f64
  end

  # Unwrapped version of `#chisq`.
  private def self.__cdf_chisq64(x : Float64, df : Float64) : Float64
    x <= 0.0 && return 0.0
    Alea::Core::SpecFun::Gamma.incomplete_reg(df * 0.5, x * 0.5, :lower)
  end

  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `df`: degrees of freedom of the distribution;
  #   usually mentioned as **`k`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `df` is negative or zero.
  def self.chisq32(x, df) : Float32
    __chisq32 x, df
  end

  # Run-time argument sanitizer for `#chisq32`.
  private def self.__chisq32(x : Number, df : Number) : Float32
    if x.class < Float
      Alea.sanity_check(x, :x, :chisq32)
    end

    if df.class < Float
      Alea.sanity_check(df, :df, :chisq32)
    end

    Alea.param_check(df, :<=, 0.0, :df, :chisq32)

    __cdf_chisq32 x.to_f32, df.to_f32
  end

  # Unwrapped version of `#chisq32`.
  private def self.__cdf_chisq32(x : Float32, df : Float32) : Float32
    x <= 0.0f32 && return 0.0f32
    Alea::Core::SpecFun::Gamma.incomplete_reg(df * 0.5f32, x * 0.5f32, :lower)
  end
end
