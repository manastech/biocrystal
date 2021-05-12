module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `k`.
  #
  # **@parameters**:
  # * `k`: discrete-valued quantile of which estimate the cdf.
  # * `lam`: separation parameter of the distribution;
  #   usually mentioned as **`λ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `lam` is negative or zero.
  def self.poisson(k, lam = 1.0) : Float64
    __poisson64 k, lam
  end

  # Run-time argument sanitizer for `#poisson`.
  private def self.__poisson64(k : Number, lam : Number) : Float64
    if k.class < Float
      Alea.sanity_check(k, :k, :poisson)
    end

    if lam.class < Float
      Alea.sanity_check(lam, :lam, :poisson)
    end

    Alea.param_check(lam, :<=, 0.0, :lam, :poisson)

    __cdf_poisson64 k.to_i32, lam.to_f64
  end

  # Unwrapped version of `#poisson`.
  private def self.__cdf_poisson64(k : Int32, lam : Float64) : Float64
    k < 0 && return 0.0
    Alea::Core.inc_gamma_regular(k + 1, lam, :upper)
  end

  # Calculate the cumulative distribution function evaluated at `k`.
  #
  # **@parameters**:
  # * `k`: discrete-valued quantile of which estimate the cdf.
  # * `lam`: separation parameter of the distribution;
  #   usually mentioned as **`λ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `lam` is negative or zero.
  def self.poisson32(k, lam = 1.0f32) : Float32
    __poisson32 k, lam
  end

  # Run-time argument sanitizer for `#poisson32`.
  private def self.__poisson32(k : Number, lam : Number) : Float32
    if k.class < Float
      Alea.sanity_check(k, :k, :poisson32)
    end

    if lam.class < Float
      Alea.sanity_check(lam, :lam, :poisson32)
    end

    Alea.param_check(lam, :<=, 0.0, :lam, :poisson32)

    __cdf_poisson32 k.to_i32, lam.to_f32
  end

  # Unwrapped version of `#poisson32`.
  private def self.__cdf_poisson32(k : Int32, lam : Float32) : Float32
    k < 0 && return 0.0f32
    Alea::Core.inc_gamma_regular(k + 1, lam, :upper)
  end
end
