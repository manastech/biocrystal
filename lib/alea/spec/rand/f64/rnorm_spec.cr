require "../../spec_helper"

describe Alea do
  context "Normal" do
    describe Alea::Random do
      describe "#normal" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :normal,
          params: {loc: 1.0, sigma: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :normal,
          params: {loc: 1.0, sigma: 1.0},
          params_to_check: [:loc, :sigma],
        )

        param_test(
          caller: SpecRng,
          method: :normal,
          params: {loc: 1.0, sigma: 1.0},
          params_to_check: [:sigma],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_normal" do
        # mean  is:   m
        # stdev is:   s

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.1 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 0.1},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 0.1,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.01 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 0.01},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 0.01,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.00001 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 0.00001},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 0.00001,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 0.00000000001 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 0.00000000001},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 0.00000000001,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 3.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 3.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 3.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 10.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 10.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 10.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 100.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 100.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 100.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 1_000.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 1_000.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 10_000.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 0.0, sigma: 10_000.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 10_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 0.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 3.0 and sigma 1.0 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 3.0},
          sample_type: Float64,
          real_mean: 3.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc 93.0 and sigma 0.5 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: 93.0, sigma: 0.5},
          sample_type: Float64,
          real_mean: 93.0,
          real_stdev: 0.5,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates normal-distributed random values with fixed loc -93.0 and sigma 0.5 parameters",
          caller: SpecRng,
          method: :next_normal,
          params: {loc: -93.0, sigma: 0.5},
          sample_type: Float64,
          real_mean: -93.0,
          real_stdev: 0.5,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
