require "../core/cspec"

module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `shape`: shape parameter of the distribution;
  #   usually mentioned as **`k`**.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`θ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if any of `shape` or `scale` is negative or zero.
  def self.gamma(x, shape, scale = 1.0) : Float64
    __gamma64 x, shape, scale
  end

  # Run-time argument sanitizer for `#gamma`.
  private def self.__gamma64(x : Number, shape : Number, scale : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :gamma)
    end

    if shape.class < Float
      Alea.sanity_check(shape, :shape, :gamma)
    end

    if scale.class < Float
      Alea.sanity_check(scale, :scale, :gamma)
    end

    Alea.param_check(shape, :<=, 0.0, :shape, :gamma)
    Alea.param_check(scale, :<=, 0.0, :scale, :gamma)

    __cdf_gamma64 x.to_f64, shape.to_f64, scale.to_f64
  end

  # Unwrapped version of `#gamma`.
  private def self.__cdf_gamma64(x : Float64, shape : Float64, scale : Float64) : Float64
    x <= 0.0 && return 0.0
    Alea::Core::SpecFun::Gamma.incomplete_reg(shape, x / scale, :lower)
  end

  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `shape`: shape parameter of the distribution;
  #   usually mentioned as **`k`**.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`θ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if any of `shape` or `scale` is negative or zero.
  def self.gamma32(x, shape, scale = 1.0f32) : Float32
    __gamma32 x, shape, scale
  end

  # Run-time argument sanitizer for `#gamma32`.
  private def self.__gamma32(x : Number, shape : Number, scale : Number) : Float32
    if x.class < Float
      Alea.sanity_check(x, :x, :gamma32)
    end

    if shape.class < Float
      Alea.sanity_check(shape, :shape, :gamma32)
    end

    if scale.class < Float
      Alea.sanity_check(scale, :scale, :gamma32)
    end

    Alea.param_check(shape, :<=, 0.0, :shape, :gamma32)
    Alea.param_check(scale, :<=, 0.0, :scale, :gamma32)

    __cdf_gamma32 x.to_f32, shape.to_f32, scale.to_f32
  end

  # Unwrapped version of `#gamma32`.
  private def self.__cdf_gamma32(x : Float32, shape : Float32, scale : Float32) : Float32
    x <= 0.0f32 && return 0.0f32
    Alea::Core::SpecFun::Gamma.incomplete_reg(shape, x / scale, :lower)
  end
end
