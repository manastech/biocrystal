require "../../spec_helper"

describe Alea do
  context "Laplace" do
    describe Alea::CDF do
      describe "#laplace" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: Alea::CDF,
          method: :laplace,
          params: {x: 1.0, loc: 1.0, scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: Alea::CDF,
          method: :laplace,
          params: {x: 1.0, loc: 1.0, scale: 1.0},
          params_to_check: [:x, :loc, :scale],
        )

        param_test(
          caller: Alea::CDF,
          method: :laplace,
          params: {x: 1.0, loc: 1.0, scale: 1.0},
          params_to_check: [:scale],
          check_negatives: true,
          check_zeros: true,
        )

        it "returns the cdf of 0.0 in Laplace(0, 1)" do
          Alea::CDF.laplace(0.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in Laplace(2, 1)" do
          Alea::CDF.laplace(2.0, loc: 2.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in Laplace(0, 0.5)" do
          Alea::CDF.laplace(2.0, scale: 0.5).should eq(0.9908421805556329)
        end

        it "returns the cdf of 2.0 in Laplace(1, 0.5)" do
          Alea::CDF.laplace(2.0, loc: 1.0, scale: 0.5).should eq(0.9323323583816936)
        end

        it "returns the cdf of -2.0 in Laplace(-2, 1)" do
          Alea::CDF.laplace(-2.0, loc: -2.0).should eq(0.5)
        end

        it "returns the cdf of -2.0 in Laplace(0, 0.5)" do
          Alea::CDF.laplace(-2.0, scale: 0.5).should eq(0.00915781944436709)
        end

        it "returns the cdf of -2.0 in Laplace(1, 0.5)" do
          Alea::CDF.laplace(-2.0, loc: 1.0, scale: 0.5).should eq(0.0012393760883331792)
        end
      end
    end
  end
end
