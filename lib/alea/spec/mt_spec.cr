require "./spec_helper"

describe Alea do
  describe Alea::MT19937 do
    describe "Alea::MT19937.secure" do
      it "returns a new instance from class" do
        Alea::MT19937.secure.should be_a(Alea::MT19937)
      end
    end

    it "returns a new instance from class" do
      Alea::MT19937.new.should be_a(Alea::MT19937)
    end

    it "creates a new instance from seeds" do
      Alea::MT19937.new(12345).should be_a(Alea::MT19937)
      Alea::MT19937.new(12345, 54321).should be_a(Alea::MT19937)
    end

    it "generates sames numbers from same initial state concurrently" do
      rng1 = Alea::MT19937.new 93
      rng2 = Alea::MT19937.new 93

      1_000_000.times do
        rng1.next_u64.should eq(rng2.next_u64)
      end
    end

    it "generates different numbers from different initial state" do
      rng1 = Alea::MT19937.new 93
      rng2 = Alea::MT19937.new 193

      1_000_000.times do
        rng1.next_u64.should_not eq(rng2.next_u64)
      end
    end

    describe "#next_u32" do
      it "returns a UInt32" do
        rng = Alea::MT19937.new
        rnd = rng.next_u32
        rnd.should be_a(UInt32)
      end

      it "returns a UInt32 with given initial seed" do
        rng = Alea::MT19937.new 9377
        rnd = rng.next_u32
        rnd.should be_a(UInt32)
      end

      it "returns uniformly-distributed random values" do
        ary = Array(UInt32).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_u32
          ans += ran
          ary << ran
        end

        mean = ans / SpecNdata
        mean.should be_close(2147483647.5, 1.5e8)
        stdev = stdev(ary, mean, SpecNdata)
        stdev.should be_close(1239850261.9644444, 0.5e8)
      end
    end

    describe "#next_u64" do
      it "returns a UInt64" do
        rng = Alea::MT19937.new
        rnd = rng.next_u64
        rnd.should be_a(UInt64)
      end

      it "returns a UInt64 with given initial seed" do
        rng = Alea::MT19937.new 9377
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

    describe "#next_f32" do
      it "generates a Float64" do
        rng = Alea::MT19937.new
        rnd = rng.next_f32
        rnd.should be_a(Float32)
      end

      it "generates a Float64 with given initial seed" do
        rng = Alea::MT19937.new 9377
        rnd = rng.next_f32
        rnd.should be_a(Float32)
      end

      it "generates uniformly-distributed random values" do
        ary = Array(Float32).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_f32
          ans += ran
          ary << ran
        end

        mean = ans / SpecNdata
        mean.should be_close(0.5, 0.01)
        stdev = stdev(ary, mean, SpecNdata)
        stdev.should be_close(0.2886751345948129, 0.005)
      end
    end

    describe "#next_f64" do
      it "generates a Float64" do
        rng = Alea::MT19937.new
        rnd = rng.next_f64
        rnd.should be_a(Float64)
      end

      it "generates a Float64 with given initial seed" do
        rng = Alea::MT19937.new 9377
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
end
