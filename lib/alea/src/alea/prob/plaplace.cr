module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the distribution;
  #   usually mentioned as **`μ`**.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`b`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `scale` is negative or zero.
  def self.laplace(x, loc = 0.0, scale = 1.0) : Float64
    __laplace64 x, loc, scale
  end

  # Run-time argument sanitizer for `#laplace`.
  private def self.__laplace64(x : Number, loc : Number, scale : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :laplace)
    end

    if loc.class < Float
      Alea.sanity_check(loc, :loc, :laplace)
    end

    if scale.class < Float
      Alea.sanity_check(scale, :scale, :laplace)
    end

    Alea.param_check(scale, :<=, 0.0, :scale, :laplace)

    __cdf_laplace64 x.to_f64, loc.to_f64, scale.to_f64
  end

  # Unwrapped version of `#laplace`.
  private def self.__cdf_laplace64(x : Float64, loc : Float64, scale : Float64) : Float64
    a = (x - loc) / scale
    x < loc && return 0.5 * Math.exp(a)
    1.0 - 0.5 * Math.exp(-a)
  end

  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the distribution;
  #   usually mentioned as **`μ`**.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`b`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `scale` is negative or zero.
  def self.laplace32(x, loc = 0.0f32, scale = 1.0f32) : Float32
    __laplace32 x, loc, scale
  end

  # Run-time argument sanitizer for `#laplace32`.
  private def self.__laplace32(x : Number, loc : Number, scale : Number) : Float32
    if x.class < Float
      Alea.sanity_check(x, :x, :laplace32)
    end

    if loc.class < Float
      Alea.sanity_check(loc, :loc, :laplace32)
    end

    if scale.class < Float
      Alea.sanity_check(scale, :scale, :laplace32)
    end

    Alea.param_check(scale, :<=, 0.0, :scale, :laplace32)

    __cdf_laplace32 x.to_f32, loc.to_f32, scale.to_f32
  end

  # Unwrapped version of `#laplace32`.
  private def self.__cdf_laplace32(x : Float32, loc : Float32, scale : Float32) : Float32
    a = (x - loc) / scale
    x < loc && return 0.5f32 * Math.exp(a)
    1.0f32 - 0.5f32 * Math.exp(-a)
  end
end
