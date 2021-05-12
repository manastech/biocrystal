require "../../spec_helper"

describe Alea do
  context "Exponential" do
    describe Alea::CDF do
      describe "#exp32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :exp32,
          params: {x: 1.0, scale: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :exp32,
          params: {x: 1.0, scale: 1.0},
          params_to_check: [:x, :scale],
        )

        param_test(
          caller: Alea::CDF,
          method: :exp32,
          params: {x: 1.0, scale: 1.0},
          params_to_check: [:scale],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of -1.0 in Exp(1.0)" do
          Alea::CDF.exp32(-1.0).should eq(0.0f32)
        end

        it "returns the cdf of 0.0 in Exp(1.0)" do
          Alea::CDF.exp32(0.0).should eq(0.0f32)
        end

        it "returns the cdf of 1.0 in Exp(1.0)" do
          Alea::CDF.exp32(1.0).should eq(0.63212055f32)
        end

        it "returns the cdf of 2.0 in Exp(1.0)" do
          Alea::CDF.exp32(2.0).should eq(0.86466473f32)
        end

        it "returns the cdf of 1.0 in Exp(0.5)" do
          Alea::CDF.exp32(1.0, scale: 0.5).should eq(0.86466473f32)
        end

        it "returns the cdf of 2.0 in Exp(0.5)" do
          Alea::CDF.exp32(2.0, scale: 0.5).should eq(0.9816844f32)
        end
      end
    end
  end
end
