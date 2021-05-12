module Alea
  # `Alea::CDF` is the interface used to calculate the Cumulative Distribution Functions.
  # Given *X* ~ *D* and a fixed quantile *x*, CDFs are defined as the functions that associate *x*
  # to the probability that the real-valued random *X* from the distribution *D*
  # will take a value less or equal to *x*.
  #
  # Arguments passed to `Alea::CDF` methods to shape the distributions are analogous to those used for sampling:
  #
  # ```
  # Alea::CDF.normal(0.0)                       # => 0.5
  # Alea::CDF.normal(2.0, loc: 1.0, sigma: 0.5) # => 0.9772498680518208
  # Alea::CDF.chisq(5.279, df: 5.0)             # => 0.6172121213841358
  # ```
  #
  # NOTE: for real-valued quantiles is used `x`, `k` for discrete-valued instead.
  module CDF
  end
end
