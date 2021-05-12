require "../../spec_helper"

describe Alea do
  context "Beta" do
    describe Alea::Random do
      describe "#beta32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :beta32,
          params: {a: 1.0, b: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :beta32,
          params: {a: 1.0, b: 1.0},
          params_to_check: [:a, :b],
        )

        param_test(
          caller: SpecRng,
          method: :beta32,
          params: {a: 1.0, b: 1.0},
          params_to_check: [:a, :b],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_beta32" do
        # mean  is:   1.0 / (1.0 + (b / a))
        # stdev is:   sqrt( ab / ((a + b)^2 * (a + b + 1.0)) )

        dist_test("generates beta-distributed random values with fixed a 3.0 and b 5.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 3.0f32, b: 5.0f32},
          sample_type: Float32,
          real_mean: 0.375,
          real_stdev: 0.1613743060919757,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 0.1 and b 0.1 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 0.1f32, b: 0.1f32},
          sample_type: Float32,
          real_mean: 0.5,
          real_stdev: 0.45643546458763845,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 0.0001 and b 0.0001 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 0.0001f32, b: 0.0001f32},
          sample_type: Float32,
          real_mean: 0.5,
          real_stdev: 0.49995000749875024,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 1.0 and b 1.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 1.0f32, b: 1.0f32},
          sample_type: Float32,
          real_mean: 0.5,
          real_stdev: 0.28867513459481287,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 1.0 and b 10.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 1.0f32, b: 10.0f32},
          sample_type: Float32,
          real_mean: 0.09090909090909091,
          real_stdev: 0.08298826628866153,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 1.0 and b 100.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 1.0f32, b: 100.0f32},
          sample_type: Float32,
          real_mean: 0.009900990099009901,
          real_stdev: 0.009803441019571034,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 1.0 and b 10_000.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 1.0f32, b: 10_000.0f32},
          sample_type: Float32,
          real_mean: 9.999000099990002e-5,
          real_stdev: 9.99800034994001e-5,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 10.0 and b 1.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 10.0f32, b: 1.0f32},
          sample_type: Float32,
          real_mean: 0.9090909090909091,
          real_stdev: 0.08298826628866153,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 100.0 and b 1.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 100.0f32, b: 1.0f32},
          sample_type: Float32,
          real_mean: 0.9900990099009901,
          real_stdev: 0.009803441019571034,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates beta-distributed random values with fixed a 10_000.0 and b 1.0 parameters",
          caller: SpecRng,
          method: :next_beta32,
          params: {a: 10_000.0f32, b: 1.0f32},
          sample_type: Float32,
          real_mean: 0.9999000099990001,
          real_stdev: 9.99800034994001e-5,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )
      end
    end
  end
end
