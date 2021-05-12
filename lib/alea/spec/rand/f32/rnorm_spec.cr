require "../../spec_helper"

describe Alea do
  context "Normal" do
    describe Alea::Random do
      describe "#normal32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :normal32,
          params: {loc: 1.0, sigma: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :normal32,
          params: {loc: 1.0, sigma: 1.0},
          params_to_check: [:loc, :sigma],
        )

        param_test(
          caller: SpecRng,
          method: :normal32,
          params: {loc: 1.0, sigma: 1.0},
          params_to_check: [:sigma],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_normal32" do
        # mean  is:   m
        # stdev is:   s

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.1 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 0.1f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 0.1,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.01 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 0.01f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 0.01,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.00001 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 0.00001f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 0.00001,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 3.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 3.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 3.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 10.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 10.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 10.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 100.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 100.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 100.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 1_000.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 1_000.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 1_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 10_000.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 0.0f32, sigma: 10_000.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 10_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 3.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 3.0f32},
          sample_type: Float32,
          real_mean: 3.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 93.0 and sigma 0.5 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: 93.0f32, sigma: 0.5f32},
          sample_type: Float32,
          real_mean: 93.0,
          real_stdev: 0.5,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc -93.0 and sigma 0.5 parameters",
          caller: SpecRng,
          method: :next_normal32,
          params: {loc: -93.0f32, sigma: 0.5f32},
          sample_type: Float32,
          real_mean: -93.0,
          real_stdev: 0.5,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
