require "../../spec_helper"

describe Alea do
  context "Gamma" do
    describe Alea::Random do
      describe "#gamma32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :gamma32,
          params: {shape: 1.0, scale: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :gamma32,
          params: {shape: 1.0, scale: 1.0},
          params_to_check: [:shape, :scale],
        )

        param_test(
          caller: SpecRng,
          method: :gamma32,
          params: {shape: 1.0, scale: 1.0},
          params_to_check: [:shape, :scale],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_gamma32" do
        # mean  is:   ks
        # stdev is:   sqrt( ks^2 )

        dist_test("generates gamma-distributed random values with fixed shape 0.1 and scale 0.1 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 0.1f32, scale: 0.1f32},
          sample_type: Float32,
          real_mean: 0.01,
          real_stdev: 0.0316227766016838,
          mean_tol: 0.005,
          stdev_tol: 0.05,
        )

        dist_test("generates gamma-distributed random values with fixed shape 0.0001 and scale 0.0001 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 0.0001f32, scale: 0.0001f32},
          sample_type: Float32,
          real_mean: 0.00000001,
          real_stdev: 1.0e-6,
          mean_tol: 0.005,
          stdev_tol: 0.2,
        )

        dist_test("generates gamma-distributed random values with fixed shape 1.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 1.0f32, scale: 1.0f32},
          sample_type: Float32,
          real_mean: 1.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 1.0 and scale 10.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 1.0f32, scale: 10.0f32},
          sample_type: Float32,
          real_mean: 10.0,
          real_stdev: 10.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 1.0 and scale 100.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 1.0f32, scale: 100.0f32},
          sample_type: Float32,
          real_mean: 100.0,
          real_stdev: 100.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 1.0 and scale 10_000.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 1.0f32, scale: 10_000.0f32},
          sample_type: Float32,
          real_mean: 10_000.0,
          real_stdev: 10_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 10.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 10.0f32, scale: 1.0f32},
          sample_type: Float32,
          real_mean: 10.0,
          real_stdev: 3.1622776601683795,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 100.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 100.0f32, scale: 1.0f32},
          sample_type: Float32,
          real_mean: 100.0,
          real_stdev: 10.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 10_000.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 10_000.0f32, scale: 1.0f32},
          sample_type: Float32,
          real_mean: 10_000.0,
          real_stdev: 100.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates gamma-distributed random values with fixed shape 3.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 3.0f32, scale: 1.0f32},
          sample_type: Float32,
          real_mean: 3.0,
          real_stdev: 1.7320508075688772,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates gamma-distributed random values with fixed shape 3.0 and scale 1.5 parameters",
          caller: SpecRng,
          method: :next_gamma32,
          params: {shape: 3.0f32, scale: 1.5f32},
          sample_type: Float32,
          real_mean: 4.5,
          real_stdev: 2.598076211353316,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
