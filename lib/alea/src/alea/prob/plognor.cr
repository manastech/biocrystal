module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the underlying normal distribution;
  #   usually mentioned as **`μ`**.
  # * `sigma`: scale parameter, or standard deviation of the underlying normal distribution;
  #   usually mentioned as **`σ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `sigma` is negative or zero.
  def self.lognormal(x, loc = 0.0, sigma = 1.0) : Float64
    __lognormal64 x, loc, sigma
  end

  # Run-time argument sanitizer for `#lognormal`.
  private def self.__lognormal64(x : Number, loc : Number, sigma : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :lognormal)
    end

    if loc.class < Float
      Alea.sanity_check(loc, :loc, :lognormal)
    end

    if sigma.class < Float
      Alea.sanity_check(sigma, :sigma, :lognormal)
    end

    Alea.param_check(sigma, :<=, 0.0, :sigma, :lognormal)

    __cdf_lognormal64 x.to_f64, loc.to_f64, sigma.to_f64
  end

  # Unwrapped version of `#lognormal`.
  private def self.__cdf_lognormal64(x : Float64, loc : Float64, sigma : Float64) : Float64
    x <= 0.0 && return 0.0
    0.5 + 0.5 * (Math.erf((Math.log(x) - loc) / (sigma * 1.4142135623730951)))
  end

  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the underlying normal distribution;
  #   usually mentioned as **`μ`**.
  # * `sigma`: scale parameter, or standard deviation of the underlying normal distribution;
  #   usually mentioned as **`σ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `sigma` is negative or zero.
  def self.lognormal32(x, loc = 0.0f32, sigma = 1.0f32) : Float32
    __lognormal32 x, loc, sigma
  end

  # Run-time argument sanitizer for `#lognormal32`.
  private def self.__lognormal32(x : Number, loc : Number, sigma : Number) : Float32
    if x.class < Float
      Alea.sanity_check(x, :x, :lognormal32)
    end

    if loc.class < Float
      Alea.sanity_check(loc, :loc, :lognormal32)
    end

    if sigma.class < Float
      Alea.sanity_check(sigma, :sigma, :lognormal32)
    end

    Alea.param_check(sigma, :<=, 0.0, :sigma, :lognormal32)

    __cdf_lognormal32 x.to_f32, loc.to_f32, sigma.to_f32
  end

  # Unwrapped version of `#lognormal32`.
  private def self.__cdf_lognormal32(x : Float32, loc : Float32, sigma : Float32) : Float32
    x <= 0.0f32 && return 0.0f32
    0.5f32 + 0.5f32 * (Math.erf((Math.log(x) - loc) / (sigma * 1.4142135623730951f32)))
  end
end
