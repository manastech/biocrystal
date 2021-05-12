require "../../spec_helper"

describe Alea do
  context "Lognormal" do
    describe Alea::CDF do
      describe "#lognormal32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :lognormal32,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :lognormal32,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          params_to_check: [:x, :loc, :sigma],
        )

        param_test(
          caller: Alea::CDF,
          method: :lognormal32,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          params_to_check: [:sigma],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of 0.0 in LogN(0, 1)" do
          Alea::CDF.lognormal32(0.0).should eq(0.0f32)
        end

        it "returns the cdf of 1.0 in LogN(0, 1)" do
          Alea::CDF.lognormal32(1.0).should eq(0.5f32)
        end

        it "returns the cdf of -1.0 in LogN(0, 1)" do
          Alea::CDF.lognormal32(-1.0).should eq(0.0f32)
        end

        it "returns the cdf of 2.0 in LogN(2, 1)" do
          Alea::CDF.lognormal32(2.0, loc: 2.0).should eq(0.09563136f32)
        end

        it "returns the cdf of 2.0 in LogN(0, 0.5)" do
          Alea::CDF.lognormal32(2.0, sigma: 0.5).should eq(0.9171715f32)
        end

        it "returns the cdf of 2.0 in LogN(1, 0.5)" do
          Alea::CDF.lognormal32(2.0, loc: 1.0, sigma: 0.5).should eq(0.26970494f32)
        end
      end
    end
  end
end
