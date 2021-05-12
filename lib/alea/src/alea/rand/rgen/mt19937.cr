require "../../core/cerr"
require "../../core/cgen"
require "./prng"

module Alea
  # `MT19937` engine is an implementation of the famous
  # [Mersenne Twister](http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html), developed by Makoto
  # Matsumoto and Takuji Nishimura: the most widely used PRNG passing most strict statistical tests.
  #
  # ```text
  #  - period: (2^19937)-1
  #  - init:   `Alea::Core::Knuth32`
  # ```
  class MT19937
    include Alea::PRNG(UInt32, UInt32)

    STATE_LEN_N = 624
    STATE_LEN_M = 397

    UPPER_MASK = 0x80000000_u64
    LOWER_MASK = 0x7fffffff_u64

    MATRIX_A = 0x9908b0df_u64

    TEMPERING_B = 0x9d2c5680_u64
    TEMPERING_C = 0xefc60000_u64

    # The state this PRNG refers to when called for generating `UInt32`s.
    @state32 : StaticArray(UInt32, STATE_LEN_N)

    # The current state32 position
    @pos32 : Int32

    # The state this PRNG refers to when called for generating `UInt64`s.
    @state64 : StaticArray(UInt32, STATE_LEN_N)

    # The current state64 position
    @pos64 : Int32

    # The seed this PRNG received to initialize `@state32`.
    @seed32 : UInt32

    # The seed this PRNG received to initialize `@state64`.
    @seed64 : UInt32

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to initialize the state of 32-bit generators.
    # * `seed64`: value as input to initialize the state of 64-bit generators.
    #
    # **@references**:
    # * `Alea::Core::Knuth32(624)#init_state`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def initialize(@seed32 : UInt32, @seed64 : UInt32)
      @state32 = Alea::Core::Knuth32(STATE_LEN_N).init_state @seed32
      @state64 = Alea::Core::Knuth32(STATE_LEN_N).init_state @seed64
      @pos32 = STATE_LEN_N
      @pos64 = STATE_LEN_N
    end

    # Generate a uniform-distributed random `UInt32`.
    #
    # **@examples**:
    # ```
    # rng = Alea::MT19937.new
    # rng.next_u32 # => 2604272037
    # ```
    @[AlwaysInline]
    def next_u32 : UInt32
      @pos32 == STATE_LEN_N && mt32_gen

      rnd = @state32[@pos32]
      @pos32 += 1

      # Tempering
      rnd ^= (rnd >> 11)
      rnd ^= (rnd << 7) & TEMPERING_B
      rnd ^= (rnd << 15) & TEMPERING_C
      rnd ^ (rnd >> 18)
    end

    # Generate a uniform-distributed random `UInt64`.
    #
    # **@examples**:
    # ```
    # rng = Alea::MT19937.new
    # rng.next_u64 # => 11185263231290389851
    # ```
    @[AlwaysInline]
    def next_u64 : UInt64
      @pos64 == STATE_LEN_N && mt64_gen

      rnd0 = @state64[@pos64]
      rnd1 = @state64[@pos64 + 1]
      @pos64 += 2

      # Tempering
      {% for i in ["0".id, "1".id] %}
        rnd{{i}} ^= (rnd{{i}} >> 11)
        rnd{{i}} ^= (rnd{{i}} << 7) & TEMPERING_B
        rnd{{i}} ^= (rnd{{i}} << 15) & TEMPERING_C
        rnd{{i}} ^= (rnd{{i}} >> 18)
      {% end %}

      ((0u64 | rnd0) << 32) | rnd1
    end

    {% for s in ["32".id, "64".id] %}
      protected def mt{{s}}_gen
        step = STATE_LEN_N - STATE_LEN_M

        step.times do |i|
          tmp = (@state{{s}}[i] & UPPER_MASK) | (@state{{s}}[i + 1] & LOWER_MASK)
          sig = (-Int{{s}}.new!(tmp & 1) & MATRIX_A)
          @state{{s}}[i] = @state{{s}}[i + STATE_LEN_M] ^ (tmp >> 1) ^ sig
        end

        (step...STATE_LEN_N-1).each do |i|
          tmp = (@state{{s}}[i] & UPPER_MASK) | (@state{{s}}[i + 1] & LOWER_MASK)
          sig = (-Int{{s}}.new!(tmp & 1) & MATRIX_A)
          @state{{s}}[i] = @state{{s}}[i + (STATE_LEN_M - STATE_LEN_N)] ^ (tmp >> 1) ^ sig
        end

        tmp = (@state{{s}}[STATE_LEN_N - 1] & UPPER_MASK) | (@state{{s}}[0] & LOWER_MASK)
        sig = (-Int{{s}}.new!(tmp & 1) & MATRIX_A)
        @state{{s}}[STATE_LEN_N - 1] = @state{{s}}[STATE_LEN_M - 1] ^ (tmp >> 1) ^ sig

        @pos{{s}} = 0
      end
    {% end %}
  end
end
