require "../../spec_helper"

describe Alea do
  context "Normal" do
    describe Alea::CDF do
      describe "#normal32" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :normal32,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          return_type: Float32,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :normal32,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          params_to_check: [:x, :loc, :sigma],
        )

        param_test(
          caller: Alea::CDF,
          method: :normal32,
          params: {x: 1.0, loc: 1.0, sigma: 1.0},
          params_to_check: [:sigma],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of 0.0 in N(0, 1)" do
          Alea::CDF.normal32(0.0).should eq(0.5f32)
        end

        it "returns the cdf of 2.0 in N(2, 1)" do
          Alea::CDF.normal32(2.0, loc: 2.0).should eq(0.5f32)
        end

        it "returns the cdf of 2.0 in N(0, 0.5)" do
          Alea::CDF.normal32(2.0, sigma: 0.5).should eq(0.9999683f32)
        end

        it "returns the cdf of 2.0 in N(1, 0.5)" do
          Alea::CDF.normal32(2.0, loc: 1.0, sigma: 0.5).should eq(0.97724986f32)
        end

        it "returns the cdf of -2.0 in N(-2, 1)" do
          Alea::CDF.normal32(-2.0, loc: -2.0).should eq(0.5f32)
        end

        it "returns the cdf of -2.0 in N(0, 0.5)" do
          Alea::CDF.normal32(-2.0, sigma: 0.5).should eq(3.167987e-5f32)
        end

        it "returns the cdf of -2.0 in N(1, 0.5)" do
          Alea::CDF.normal32(-2.0, loc: 1.0, sigma: 0.5).should eq(0.0f32)
        end
      end
    end
  end
end
