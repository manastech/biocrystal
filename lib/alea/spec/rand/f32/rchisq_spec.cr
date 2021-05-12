require "../../spec_helper"

describe Alea do
  context "ChiSquare" do
    describe Alea::Random do
      describe "#chisq32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :chisq32,
          params: {df: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :chisq32,
          params: {df: 1.0},
          params_to_check: [:df],
        )

        param_test(
          caller: SpecRng,
          method: :chisq32,
          params: {df: 1.0},
          params_to_check: [:df],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_chisq32" do
        # mean  is:   k
        # stdev is:   sqrt( 2k )

        dist_test("generates chi^2-distributed random values with fixed df 1.0 parameter",
          caller: SpecRng,
          method: :next_chisq32,
          params: {df: 1.0f32},
          sample_type: Float32,
          real_mean: 1.0,
          real_stdev: 1.4142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates chi^2-distributed random values with fixed df 3.0 parameter",
          caller: SpecRng,
          method: :next_chisq32,
          params: {df: 3.0f32},
          sample_type: Float32,
          real_mean: 3.0,
          real_stdev: 2.449489742783178,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates chi^2-distributed random values with fixed df 10.0 parameter",
          caller: SpecRng,
          method: :next_chisq32,
          params: {df: 10.0f32},
          sample_type: Float32,
          real_mean: 10.0,
          real_stdev: 4.47213595499958,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates chi^2-distributed random values with fixed df 100.0 parameter",
          caller: SpecRng,
          method: :next_chisq32,
          params: {df: 100.0f32},
          sample_type: Float32,
          real_mean: 100.0,
          real_stdev: 14.142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates chi^2-distributed random values with fixed df 1_000.0 parameter",
          caller: SpecRng,
          method: :next_chisq32,
          params: {df: 1_000.0f32},
          sample_type: Float32,
          real_mean: 1_000.0,
          real_stdev: 44.721359549995796,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates chi^2-distributed random values with fixed df 10_000.0 parameter",
          caller: SpecRng,
          method: :next_chisq32,
          params: {df: 10_000.0f32},
          sample_type: Float32,
          real_mean: 10_000.0,
          real_stdev: 141.4213562373095,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )
      end
    end
  end
end
