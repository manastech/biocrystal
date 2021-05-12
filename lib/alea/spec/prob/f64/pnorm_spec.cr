require "../../spec_helper"

describe Alea do
  context "Normal" do
    describe Alea::CDF do
      describe "#normal" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :normal,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :normal,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          params_to_check: [:x, :loc, :sigma],
        )

        param_test(
          caller: Alea::CDF,
          method: :normal,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          params_to_check: [:sigma],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of 0.0 in N(0, 1)" do
          Alea::CDF.normal(0.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in N(2, 1)" do
          Alea::CDF.normal(2.0, loc: 2.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in N(0, 0.5)" do
          Alea::CDF.normal(2.0, sigma: 0.5).should eq(0.9999683287581669)
        end

        it "returns the cdf of 2.0 in N(1, 0.5)" do
          Alea::CDF.normal(2.0, loc: 1.0, sigma: 0.5).should eq(0.9772498680518208)
        end

        it "returns the cdf of -2.0 in N(-2, 1)" do
          Alea::CDF.normal(-2.0, loc: -2.0).should eq(0.5)
        end

        it "returns the cdf of -2.0 in N(0, 0.5)" do
          Alea::CDF.normal(-2.0, sigma: 0.5).should eq(3.167124183311998e-5)
        end

        it "returns the cdf of -2.0 in N(1, 0.5)" do
          Alea::CDF.normal(-2.0, loc: 1.0, sigma: 0.5).should eq(9.865876449133282e-10)
        end
      end
    end
  end
end
