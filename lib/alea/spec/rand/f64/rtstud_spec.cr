require "../../spec_helper"

describe Alea do
  context "T-Student" do
    describe Alea::Random do
      describe "#t" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :t,
          params: {df: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :t,
          params: {df: 1.0},
          params_to_check: [:df],
        )

        param_test(
          caller: SpecRng,
          method: :t,
          params: {df: 1.0},
          params_to_check: [:df],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_t" do
        # mean  is:   0
        # stdev is:   sqrt ( df / (df - 2) )

        dist_test("generates t-student-distributed random values with fixed df 3.0 parameter",
          caller: SpecRng,
          method: :next_t,
          params: {df: 3.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.7320508075688772,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates t-student-distributed random values with fixed df 10.0 parameter",
          caller: SpecRng,
          method: :next_t,
          params: {df: 10.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.118033988749895,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates t-student-distributed random values with fixed df 100.0 parameter",
          caller: SpecRng,
          method: :next_t,
          params: {df: 100.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.0101525445522108,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates t-student-distributed random values with fixed df 1_000.0 parameter",
          caller: SpecRng,
          method: :next_t,
          params: {df: 1_000.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.0010015025043828,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates t-student-distributed random values with fixed df 10_000.0 parameter",
          caller: SpecRng,
          method: :next_t,
          params: {df: 10_000.0},
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.0001000150025003,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )
      end
    end
  end
end
