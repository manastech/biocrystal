require "../../spec_helper"

describe Alea do
  context "Uniform" do
    describe Alea::Random do
      describe "#float" do
        it "accepts any sized Int/UInt/Float as argument(s)" do
          {% begin %}
            {% types = [Int8, Int16, Int32, Int64, Int128,
                        UInt8, UInt16, UInt32, UInt64, UInt128,
                        Float32, Float64] %}

            {% for t1 in types %}
              %args = { max: {{t1}}.new(1) }
              SpecRng.float( **%args ).should be_a(Float64)

              {% for t2 in types %}
                %args = { min: {{t1}}.new(0), max: {{t2}}.new(1) }
                SpecRng.float( **%args ).should be_a(Float64)

                %args = { range: ( {{t1}}.new(0)..{{t2}}.new(1) ) }
                SpecRng.float( **%args ).should be_a(Float64)

                %args = { range: ( {{t1}}.new(0)...{{t2}}.new(1) ) }
                SpecRng.float( **%args ).should be_a(Float64)
              {% end %}
            {% end %}
          {% end %}
        end

        sanity_test(
          caller: SpecRng,
          method: :float,
          params: {max: 1.0},
          params_to_check: [:max],
        )

        sanity_test(
          caller: SpecRng,
          method: :float,
          params: {min: 0.0, max: 1.0},
          params_to_check: [:min, :max],
        )

        param_test(
          caller: SpecRng,
          method: :float,
          params: {max: 1.0},
          params_to_check: [:max],
          check_negatives: true,
          check_zeros: true,
        )

        it "raises Alea::UndefinedError if min is less than max" do
          expect_raises Alea::UndefinedError do
            SpecRng.float 1.0, 0.0
          end
        end

        it "raises Alea::UndefinedError if min is eq to max" do
          expect_raises Alea::UndefinedError do
            SpecRng.float 1.0, 1.0
          end
        end

        it "raises Alea::NaNError if left bound is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float ((0.0 / 0.0)..0.0)
          end
        end

        it "raises Alea::InfinityError if left bound is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float ((1.0 / 0.0)..0.0)
          end
        end

        it "raises Alea::NaNError if right bound is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float (0.0..(0.0 / 0.0))
          end
        end

        it "raises Alea::InfinityError if right bound is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float (0.0..(1.0 / 0.0))
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float (1.0..0.0)
          end
        end

        it "raises Alea::UndefinedError if range is badly choosen" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float (1.0...1.0)
          end
        end

        it "returns an uniform-distributed in [0.0, 1.0) if max is 1.0" do
          SpecRng.float(1.0).should be < 1.0
        end

        it "returns an unique number if range only consists of it" do
          SpecRng.float(93.0..93.0).should eq(93.0)
        end

        it "returns 0.0 if max is range is 0.0..0.0" do
          SpecRng.float(0.0..0.0).should eq(0.0)
        end

        # mean  is:   (b + a) / 2
        # stdev is:   (b - a) / sqrt( 12 )

        dist_test("generates uniform-distributed random values with fixed max 9377.0 parameter",
          caller: SpecRng,
          method: :float,
          params: {max: 9377.0},
          sample_type: Float64,
          real_mean: 4688.5,
          real_stdev: 2706.9067370955604,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates uniform-distributed random values with fixed range 10...93 parameter",
          caller: SpecRng,
          method: :float,
          params: {range: 10.0...93.0},
          sample_type: Float64,
          real_mean: 51.5,
          real_stdev: 23.96003617136947,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates uniform-distributed random values with fixed range -10_000..93 parameter",
          caller: SpecRng,
          method: :float,
          params: {range: -10_000.0..93.0},
          sample_type: Float64,
          real_mean: -4953.0,
          real_stdev: 2913.8868086000416,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
