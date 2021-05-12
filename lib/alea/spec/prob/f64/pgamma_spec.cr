require "../../spec_helper"

describe Alea do
  context "Gamma" do
    describe Alea::CDF do
      describe "#gamma" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :gamma,
          params: {x: 1.0, shape: 1.0, scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :gamma,
          params: {x: 1.0, shape: 1.0, scale: 1.0},
          params_to_check: [:x, :shape, :scale],
        )

        param_test(
          caller: Alea::CDF,
          method: :gamma,
          params: {x: 1.0, shape: 1.0, scale: 1.0},
          params_to_check: [:shape, :scale],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of -1.0 in G(1, 1)" do
          Alea::CDF.gamma(-1.0, shape: 1.0, scale: 1.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in G(1, 1)" do
          Alea::CDF.gamma(0.0, shape: 1.0, scale: 1.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in G(1, 1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.86466471676338730810
          cv = Alea::CDF.gamma(2.0, shape: 1.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 0.5 in G(10, 1)" do
          # Percent err
          tol = 1.0e-13
          # From WolframAlpha
          wf = 1.7096700293489033e-10
          cv = Alea::CDF.gamma(0.5, shape: 10.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in G(10, 1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00004649807501726380
          cv = Alea::CDF.gamma(2.0, shape: 10.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214.0 in G(100, 1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.9999999999999999988291
          cv = Alea::CDF.gamma(214.0, shape: 100.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
