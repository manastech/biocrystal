require "../../spec_helper"

describe Alea do
  context "ChiSquare" do
    describe Alea::CDF do
      describe "#chisq" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :chisq,
          params: {x: 1.0, df: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :chisq,
          params: {x: 1.0, df: 1.0},
          params_to_check: [:x, :df],
        )

        param_test(
          caller: Alea::CDF,
          method: :chisq,
          params: {x: 1.0, df: 1.0},
          params_to_check: [:df],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of -1.0 in X2(1)" do
          Alea::CDF.chisq(-1.0, df: 1.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in X2(1)" do
          Alea::CDF.chisq(0.0, df: 1.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in X2(1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.842700792949714869341
          cv = Alea::CDF.chisq(2.0, df: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in X2(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 6.6117105610342475e-06
          cv = Alea::CDF.chisq(0.5, df: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in X2(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00365984682734371234
          cv = Alea::CDF.chisq(2.0, df: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214.0 in X2(100)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.99999999972060354684
          cv = Alea::CDF.chisq(214.0, df: 100.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
