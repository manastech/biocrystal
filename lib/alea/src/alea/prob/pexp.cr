module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`λ^-1`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `scale` is negative or zero.
  def self.exp(x, scale = 1.0) : Float64
    __exp64 x, scale
  end

  # Run-time argument sanitizer for `#exp`.
  private def self.__exp64(x : Number, scale : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :exp)
    end

    if scale.class < Float
      Alea.sanity_check(scale, :scale, :exp)
    end

    Alea.param_check(scale, :<=, 0.0, :scale, :exp)

    __cdf_exp64 x.to_f64, scale.to_f64
  end

  # Unwrapped version of `#exp`.
  private def self.__cdf_exp64(x : Float64, scale : Float64) : Float64
    x <= 0.0 && return 0.0
    1.0 - Math.exp(-x / scale)
  end

  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`λ^-1`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `scale` is negative or zero.
  def self.exp32(x, scale = 1.0f32) : Float32
    __exp32 x, scale
  end

  # Run-time argument sanitizer for `#exp32`.
  private def self.__exp32(x : Number, scale : Number) : Float32
    if x.class < Float
      Alea.sanity_check(x, :x, :exp32)
    end

    if scale.class < Float
      Alea.sanity_check(scale, :scale, :exp32)
    end

    Alea.param_check(scale, :<=, 0.0, :scale, :exp32)

    __cdf_exp32 x.to_f32, scale.to_f32
  end

  # Unwrapped version of `#exp32`.
  private def self.__cdf_exp32(x : Float32, scale : Float32) : Float32
    x <= 0.0f32 && return 0.0f32
    1.0f32 - Math.exp(-x / scale)
  end
end
