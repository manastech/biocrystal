require "../../spec_helper"

describe Alea do
  context "Uniform" do
    describe Alea::Random do
      describe "#uint" do
        it "accepts any sized Int/UInt/Float as argument(s)" do
          {% begin %}
            {% types = [Int8, Int16, Int32, Int64, Int128,
                        UInt8, UInt16, UInt32, UInt64, UInt128,
                        Float32, Float64] %}

            {% for t1 in types %}
              %args = { max: {{t1}}.new(1) }
              SpecRng.uint( **%args ).should be_a(UInt64)

              {% for t2 in types %}
                %args = { min: {{t1}}.new(0), max: {{t2}}.new(1) }
                SpecRng.uint( **%args ).should be_a(UInt64)

                %args = { range: ( {{t1}}.new(0)..{{t2}}.new(1) ) }
                SpecRng.uint( **%args ).should be_a(UInt64)

                %args = { range: ( {{t1}}.new(0)...{{t2}}.new(1) ) }
                SpecRng.uint( **%args ).should be_a(UInt64)
              {% end %}
            {% end %}
          {% end %}
        end

        sanity_test(
          caller: SpecRng,
          method: :uint,
          params: {max: 1},
          params_to_check: [:max],
        )

        sanity_test(
          caller: SpecRng,
          method: :uint,
          params: {min: 0, max: 1},
          params_to_check: [:min, :max],
        )

        param_test(
          caller: SpecRng,
          method: :uint,
          params: {max: 1},
          params_to_check: [:max],
          check_negatives: true,
          check_zeros: true,
        )

        it "raises Alea::UndefinedError if min is less than max" do
          expect_raises Alea::UndefinedError do
            SpecRng.uint 1, 0
          end
        end

        it "raises Alea::UndefinedError if min is eq to max" do
          expect_raises Alea::UndefinedError do
            SpecRng.uint 1, 1
          end
        end

        it "raises Alea::UndefinedError if range is negative" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint (-1..0)
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint (1..0)
          end
        end

        it "raises Alea::UndefinedError if range is badly choosen" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint (1...1)
          end
        end

        it "returns 0 if max is 1" do
          SpecRng.uint(1).should eq(0)
        end

        it "returns an unique number if range only consists of it" do
          SpecRng.uint(93..93).should eq(93)
        end

        it "returns 0 if max is range is 0..0" do
          SpecRng.uint(0..0).should eq(0)
        end
      end

      describe "#next_uint" do
        # mean  is:   a / 2
        # stdev is:   a / sqrt( 12 )

        dist_test("generates uniform-distributed random values with fixed max 9377 parameter",
          caller: SpecRng,
          method: :uint,
          params: {max: 9377},
          sample_type: UInt64,
          real_mean: 4688.5,
          real_stdev: 2706.9067370955604,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates uniform-distributed random values with fixed range 10..93 parameter",
          caller: SpecRng,
          method: :uint,
          params: {range: 10..93},
          sample_type: UInt64,
          real_mean: 51.5,
          real_stdev: 24.248711305964285,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates uniform-distributed random values with fixed range 10...93 parameter",
          caller: SpecRng,
          method: :uint,
          params: {range: 10...93},
          sample_type: UInt64,
          real_mean: 51.0,
          real_stdev: 23.96003617136947,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
