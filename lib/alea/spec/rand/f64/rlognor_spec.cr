require "../../spec_helper"

describe Alea do
  context "Lognormal" do
    describe Alea::Random do
      describe "#lognormal" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :lognormal,
          params: {loc: 1.0, sigma: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :lognormal,
          params: {loc: 1.0, sigma: 1.0},
          params_to_check: [:loc, :sigma],
        )

        param_test(
          caller: SpecRng,
          method: :lognormal,
          params: {loc: 1.0, sigma: 1.0},
          params_to_check: [:sigma],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_lognormal" do
        # mean  is:   exp( m + s^2 / 2 )
        # stdev is:   sqrt( exp(2m + s^2) * (exp(s^2) - 1) )

        dist_test("generates log-normal-distributed random values with fixed loc 0.0 and sigma 0.1 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: 0.0, sigma: 0.1},
          sample_type: Float64,
          real_mean: 1.005012520859401,
          real_stdev: 0.10075302944620396,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc 0.0 and sigma 0.01 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: 0.0, sigma: 0.01},
          sample_type: Float64,
          real_mean: 1.0000500012500209,
          real_stdev: 0.010000750030211357,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc 0.0 and sigma 0.00001 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: 0.0, sigma: 0.00001},
          sample_type: Float64,
          real_mean: 1.00000000005,
          real_stdev: 1.0000000414201846e-5,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc 0.0 and sigma 10.0 parameters",
          pending: true,
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: 0.0, sigma: 10.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 2.6881171418161356e+43,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc 0.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          sample_type: Float64,
          real_mean: 1.6487212707001282,
          real_stdev: 2.1611974158950877,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc 3.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: 3.0},
          sample_type: Float64,
          real_mean: 33.11545195869231,
          real_stdev: 43.40881049525856,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc 3.0 and sigma 0.5 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: 3.0, sigma: 0.5},
          sample_type: Float64,
          real_mean: 22.75989509352673,
          real_stdev: 12.129666457739873,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )

        dist_test("generates log-normal-distributed random values with fixed loc -3.0 and sigma 0.5 parameters",
          caller: SpecRng,
          method: :next_lognormal,
          params: {loc: -3.0, sigma: 0.5},
          sample_type: Float64,
          real_mean: 0.05641613950377735,
          real_stdev: 0.03006643713435963,
          mean_tol: 0.005,
          stdev_tol: 0.007,
        )
      end
    end
  end
end
