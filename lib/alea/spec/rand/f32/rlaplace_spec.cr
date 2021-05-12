require "../../spec_helper"

describe Alea do
  context "Laplace" do
    describe Alea::Random do
      describe "#laplace32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :laplace32,
          params: {loc: 1.0, scale: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :laplace32,
          params: {loc: 1.0, scale: 1.0},
          params_to_check: [:loc, :scale],
        )

        param_test(
          caller: SpecRng,
          method: :laplace32,
          params: {loc: 1.0, scale: 1.0},
          params_to_check: [:scale],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_laplace32" do
        # mean  is:   m
        # stdev is:   k * sqrt( 2 )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 0.1 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 0.1f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 0.14142135623730953,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 0.01 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 0.01f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 0.014142135623730952,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 0.00001 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 0.00001f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 1.4142135623730953e-5,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 1.4142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 3.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 3.0f32},
          sample_type: Float32,
          real_mean: 3.0,
          real_stdev: 1.4142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 3.0 and scale 1.5 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 3.0f32, scale: 1.5f32},
          sample_type: Float32,
          real_mean: 3.0,
          real_stdev: 2.121320343559643,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 10.0 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 10.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 14.142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 100.0 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 100.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 141.42135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 1_000.0 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 1_000.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 1414.2135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 10_000.0 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 0.0f32, scale: 10_000.0f32},
          sample_type: Float32,
          real_mean: 0.0,
          real_stdev: 14142.135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 93.0 and scale 0.5 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: 93.0f32, scale: 0.5f32},
          sample_type: Float32,
          real_mean: 93.0,
          real_stdev: 0.7071067811865476,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc -93.0 and scale 0.5 parameters",
          caller: SpecRng,
          method: :next_laplace32,
          params: {loc: -93.0f32, scale: 0.5f32},
          sample_type: Float32,
          real_mean: -93.0,
          real_stdev: 0.7071067811865476,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
