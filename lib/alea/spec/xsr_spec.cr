require "./spec_helper"

describe Alea do
  {% for size in ["128".id, "256".id] %}
    describe Alea::XSR{{size}} do
      describe "Alea::XSR{{size}}.secure" do
        it "returns a new instance from class" do
          Alea::XSR{{size}}.secure.should be_a(Alea::XSR{{size}})
        end
      end

      it "returns a new instance from class" do
        Alea::XSR{{size}}.new.should be_a(Alea::XSR{{size}})
      end

      it "creates a new instance from seeds" do
        Alea::XSR{{size}}.new(12345).should be_a(Alea::XSR{{size}})
        Alea::XSR{{size}}.new(12345, 54321).should be_a(Alea::XSR{{size}})
      end

      it "generates sames numbers from same initial state concurrently" do
        rng1 = Alea::XSR{{size}}.new 93
        rng2 = Alea::XSR{{size}}.new 93

        1_000_000.times do
          rng1.next_u64.should eq(rng2.next_u64)
        end
      end

      it "generates different numbers from different initial state" do
        rng1 = Alea::XSR{{size}}.new 93
        rng2 = Alea::XSR{{size}}.new 193

        1_000_000.times do
          rng1.next_u64.should_not eq(rng2.next_u64)
        end
      end

      describe "#next_u" do
        it "returns a UInt64" do
          rng = Alea::XSR{{size}}.new
          rnd = rng.next_u64
          rnd.should be_a(UInt64)
        end

        it "returns a UInt64 with given initial state" do
          rng = Alea::XSR{{size}}.new 9377
          rnd = rng.next_u64
          rnd.should be_a(UInt64)
        end

        it "returns uniformly-distributed random values" do
          ary = Array(UInt64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_u64
            ans += ran
            ary << ran
          end

          mean = ans / SpecNdata
          mean.should be_close(9223372036854775807.5, 1.5e16)
          stdev = stdev(ary, mean, SpecNdata)
          stdev.should be_close(5.325116328314172e+18, 0.5e18)
        end
      end

      describe "#next_f" do
        it "generates a Float64" do
          rng = Alea::XSR{{size}}.new
          rnd = rng.next_f64
          rnd.should be_a(Float64)
        end

        it "generates a Float64 with given initial state" do
          rng = Alea::XSR{{size}}.new 9377
          rnd = rng.next_f64
          rnd.should be_a(Float64)
        end

        it "generates uniformly-distributed random values" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_f64
            ans += ran
            ary << ran
          end

          mean = ans / SpecNdata
          mean.should be_close(0.5, 0.01)
          stdev = stdev(ary, mean, SpecNdata)
          stdev.should be_close(0.2886751345948129, 0.005)
        end
      end
    end
  {% end %}
end
