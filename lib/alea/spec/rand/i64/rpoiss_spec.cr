require "../../spec_helper"

describe Alea do
  context "Poisson" do
    describe Alea::Random do
      describe "#poisson" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :poisson,
          params: {lam: 1.0},
          return_type: Int64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :poisson,
          params: {lam: 1.0},
          params_to_check: [:lam],
        )

        param_test(
          caller: SpecRng,
          method: :poisson,
          params: {lam: 1.0},
          params_to_check: [:lam],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_poisson" do
        # mean  is:   l
        # stdev is:   sqrt( l )

        it "returns 0.0 if lambda is 0.0" do
          SpecRng.next_poisson(lam: 0.0).should eq(0.0)
        end

        dist_test("generates poisson-distributed random values with fixed lam 0.1 parameter",
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 0.1},
          sample_type: Int64,
          real_mean: 0.1,
          real_stdev: 0.31622776601683794,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates poisson-distributed random values with fixed lam 0.01 parameter",
          pending: true,
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 0.01},
          sample_type: Int64,
          real_mean: 0.01,
          real_stdev: 0.1,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates poisson-distributed random values with fixed lam 0.0001 parameter",
          pending: true,
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 0.0001},
          sample_type: Int64,
          real_mean: 0.0001,
          real_stdev: 0.01,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates poisson-distributed random values with fixed lam 0.0000001 parameter",
          pending: true,
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 0.0000001},
          sample_type: Int64,
          real_mean: 0.0000001,
          real_stdev: 0.00031622776601683794,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates poisson-distributed random values with fixed lam 1.0 parameter",
          caller: SpecRng,
          method: :next_poisson,
          sample_type: Int64,
          real_mean: 1.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates poisson-distributed random values with fixed lam 3.0 parameter",
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 3.0},
          sample_type: Int64,
          real_mean: 3.0,
          real_stdev: 1.7320508075688772,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates poisson-distributed random values with fixed lam 10.0 parameter",
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 10.0},
          sample_type: Int64,
          real_mean: 10.0,
          real_stdev: 3.1622776601683795,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates poisson-distributed random values with fixed lam 10_000.0 parameter",
          caller: SpecRng,
          method: :next_poisson,
          params: {lam: 10_000.0},
          sample_type: Int64,
          real_mean: 10_000.0,
          real_stdev: 100.0,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
