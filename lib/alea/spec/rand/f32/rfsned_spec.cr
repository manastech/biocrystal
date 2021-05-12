require "../../spec_helper"

describe Alea do
  context "Fisher-Snedecor" do
    describe Alea::Random do
      describe "#f32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :f32,
          params: {df1: 1.0, df2: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :f32,
          params: {df1: 1.0, df2: 1.0},
          params_to_check: [:df1, :df2],
        )

        param_test(
          caller: SpecRng,
          method: :f32,
          params: {df1: 1.0, df2: 1.0},
          params_to_check: [:df1, :df2],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_fs32" do
        # mean  is:   n / (n - 2)
        # stdev is:   sqrt( 2n**2 * (m + n - 2) / (m( n - 2 )**2 * (n - 4)) )

        dist_test("generates f-snedecor-distributed random values with fixed a 3.0 and b 5.0 parameters",
          caller: SpecRng,
          method: :next_fs32,
          params: {df1: 3.0f32, df2: 5.0f32},
          sample_type: Float32,
          real_mean: 1.6666666666666667,
          real_stdev: 3.3333333333333335,
          mean_tol: 0.005,
          stdev_tol: 0.1,
        )

        dist_test("generates f-snedecor-distributed random values with fixed a 10.0 and b 10.0 parameters",
          caller: SpecRng,
          method: :next_fs32,
          params: {df1: 10.0f32, df2: 10.0f32},
          sample_type: Float32,
          real_mean: 1.25,
          real_stdev: 0.9682458365518543,
          mean_tol: 0.005,
          stdev_tol: 0.05,
        )

        dist_test("generates f-snedecor-distributed random values with fixed a 10.0 and b 100.0 parameters",
          caller: SpecRng,
          method: :next_fs32,
          params: {df1: 10.0f32, df2: 100.0f32},
          sample_type: Float32,
          real_mean: 1.0204081632653061,
          real_stdev: 0.48402209084209885,
          mean_tol: 0.005,
          stdev_tol: 0.05,
        )

        dist_test("generates f-snedecor-distributed random values with fixed a 10.0 and b 1_000.0 parameters",
          pending: true,
          caller: SpecRng,
          method: :next_fs32,
          params: {df1: 10.0f32, df2: 1_000.0f32},
          sample_type: Float32,
          real_mean: 1.0002000400080016,
          real_stdev: 9.99800034994001e-5,
          mean_tol: 0.05,
          stdev_tol: 0.05,
        )

        dist_test("generates f-snedecor-distributed random values with fixed a 100.0 and b 10.0 parameters",
          pending: true,
          caller: SpecRng,
          method: :next_fs32,
          params: {df1: 100.0f32, df2: 10.0f32},
          sample_type: Float32,
          real_mean: 0.9900990099009901,
          real_stdev: 0.009803441019571034,
          mean_tol: 0.05,
          stdev_tol: 0.05,
        )

        dist_test("generates f-snedecor-distributed random values with fixed a 10_000.0 and b 10.0 parameters",
          pending: true,
          caller: SpecRng,
          method: :next_fs32,
          params: {df1: 10_000.0f32, df2: 10.0f32},
          sample_type: Float32,
          real_mean: 0.9999000099990001,
          real_stdev: 9.99800034994001e-5,
          mean_tol: 0.05,
          stdev_tol: 0.05,
        )
      end
    end
  end
end
