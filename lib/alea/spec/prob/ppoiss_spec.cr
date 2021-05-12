require "../spec_helper"

describe Alea do
  context "Poisson" do
    describe Alea::CDF do
      describe "#poisson" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :poisson,
          params: {k: 1, lam: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :poisson,
          params: {k: 1, lam: 1.0},
          params_to_check: [:lam],
        )

        param_test(
          caller: Alea::CDF,
          method: :poisson,
          params: {k: 1, lam: 1.0},
          params_to_check: [:lam],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of -1.0 in Poiss(1)" do
          Alea::CDF.poisson(-1).should eq(0.0)
        end

        it "returns the cdf of 0 in Poiss(1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.36787944117144232159
          cv = Alea::CDF.poisson(0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2 in Poiss(1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.91969860292860580398
          cv = Alea::CDF.poisson(2)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 1 in Poiss(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00049939922738733336
          cv = Alea::CDF.poisson(1, lam: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2 in Poiss(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00276939571551157594
          cv = Alea::CDF.poisson(2, lam: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214 in Poiss(100)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.220220646601698940243
          cv = Alea::CDF.poisson(7, lam: 10.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
