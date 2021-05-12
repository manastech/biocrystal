require "../../spec_helper"

describe Alea do
  context "Uniform" do
    describe Alea::CDF do
      describe "#uniform" do
        it "accepts any sized Int/UInt/Float as argument(s)" do
          {% begin %}
            {% types = [Int8, Int16, Int32, Int64, Int128,
                        UInt8, UInt16, UInt32, UInt64, UInt128,
                        Float32, Float64] %}

            {% for t1 in types %}
              {% for t2 in types %}
                {% for t3 in types %}
                  %args = { x: {{t1}}.new(1), min: {{t2}}.new(0), max: {{t3}}.new(1) }
                  Alea::CDF.uniform( **%args ).should be_a(Float64)
                {% end %}
              {% end %}
            {% end %}
          {% end %}
        end

        sanity_test(
          caller: Alea::CDF,
          method: :uniform,
          params: {x: 1.0, min: 1.0, max: 1.0},
          params_to_check: [:x, :min, :max],
        )

        it "raises Alea::UndefinedError if min is equal to max" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.uniform(0.0, min: 0.0, max: 0.0)
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.uniform(0.0, min: 0.0, max: -1.0)
          end
        end

        it "returns the cdf of -1.0 in U(0, 100)" do
          Alea::CDF.uniform(-1.0, min: 0.0, max: 100.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in U(0, 100)" do
          Alea::CDF.uniform(0.0, min: 0.0, max: 100.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in U(0, 100)" do
          Alea::CDF.uniform(50.0, min: 0.0, max: 100.0).should eq(0.5)
        end

        it "returns the cdf of 100.0 in U(0, 100)" do
          Alea::CDF.uniform(100.0, min: 0.0, max: 100.0).should eq(1.0)
        end

        it "returns the cdf of 101.0 in U(0, 100)" do
          Alea::CDF.uniform(101.0, min: 0.0, max: 100.0).should eq(1.0)
        end
      end
    end
  end
end
