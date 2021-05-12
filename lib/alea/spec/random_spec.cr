require "./spec_helper"

describe Alea do
  describe Alea::Random do
    describe "new" do
      {% for engine in AleaEngines %}
        context "{{engine.id}}" do
          it "creates a new instance from generic type" do
            Alea::Random({{engine.id}}).new.should be_a(Alea::Random({{engine.id}}))
          end

          it "creates a new instance from instance" do
            Alea::Random.new({{engine.id}}.new).should be_a(Alea::Random({{engine.id}}))
          end

          it "creates a new instance from seeds" do
            Alea::Random({{engine.id}}).new(12345).should be_a(Alea::Random({{engine.id}}))
            Alea::Random({{engine.id}}).new(12345, 54321).should be_a(Alea::Random({{engine.id}}))
          end

          it "generates sames numbers from same initial state concurrently" do
            rng1 = Alea::Random({{engine.id}}).new 93
            rng2 = Alea::Random({{engine.id}}).new 93

            1_000_000.times do
              rng1.next_u64.should eq(rng2.next_u64)
            end
          end
        end
      {% end %}
    end

    {% for method, type in {
                             "next_i32" => "Int32",
                             "next_i64" => "Int64",
                             "next_u32" => "UInt32",
                             "next_u64" => "UInt64",
                             "next_f32" => "Float32",
                             "next_f64" => "Float64",
                           } %}

      describe "{{method.id}}" do
        {% for engine in AleaEngines %}
          context "{{engine.id}}" do
            it "returns the next generated {{type.id}}" do
              Alea::Random({{engine.id}}).new.{{method.id}}.should be_a({{type.id}})
            end
          end
        {% end %}
      end
    {% end %}

    describe "rand" do
      it "correctly samples from arrays" do
        rng = Alea::Random(Alea::MT19937).new 27
        [6, 3, 2, 9].sample(rng).should be_a Int32
        {6, 3, 2, 9}.sample(rng).should be_a Int32
      end
    end
  end
end
