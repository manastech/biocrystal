require "./cgam"

module Alea::Core
  # Ok here to pass the prng: it's a reference and
  # it will not affect repeatability.
  def self.poisson_ptrs(lam : Float | Int, prng : Alea::PRNG)
    slam = Math.sqrt lam
    llam = Math.log lam
    b = 0.931 + 2.53 * slam
    a = -0.059 + 0.02483 * b
    inv = 1.1239 + 1.1328 / (b - 3.4)
    vr = 0.9277 - 3.6224 / (b - 2.0)
    while true
      u = prng.next_f64 - 0.5
      v = prng.next_f64
      us = 0.5 - u.abs
      k = Int64.new((2.0 * a / us + b) * u + lam + 0.43)
      ((us >= 0.07) && (v <= vr)) && return k
      ((k < 0) || ((us < 0.013) && (v > us))) && next
      log = Math.log(v) + Math.log(inv) - Math.log(a / (us * us) + b)
      gam = -(lam - k * llam + Math.lgamma(k + 1i64))
      (log <= gam) && return k
    end
  end

  # Ok here to pass the prng: it's a reference and
  # it will not affect repeatability.
  def self.poisson_mult(lam : Float | Int, prng : Alea::PRNG)
    lam = lam.to_f
    enlam = Math.exp(-lam)
    x = 0i64
    prod = 1.0
    while true
      u = prng.next_f64
      prod *= u
      (enlam >= prod) && return x
      x += 1i64
    end
  end
end
