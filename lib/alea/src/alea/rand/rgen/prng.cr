module Alea
  # `Alea::PRNG` is the module all PRNGs include in order to work with `Alea::Random`.
  #
  # As long as it includes the `Alea::PRNG` module, you can build your own generator: check
  # out the [example](https://github.com/nin93/alea/blob/master/custom_prng.cr) provided in
  # the documentation to make it a valid extension for `Alea::Random`.
  module PRNG(S32, S64)
    # Must initialize states from seeds.
    abstract def initialize(seed32 : S32, seed64 : S64)

    # Must return an uniform-distributed `UInt32`.
    abstract def next_u32 : UInt32

    # Must return an uniform-distributed `UInt64`.
    abstract def next_u64 : UInt64

    # :nodoc:
    macro included
      # Initializes the PRNG with initial seeds.
      #
      # **@parameters**:
      # * `seed32`: value as input to init. the state of 32-bit generators of `prng`.
      # * `seed64`: value as input to init. the state of 64-bit generators of `prng`.
      def self.new(seed32 : Int, seed64 : Int)
        new S32.new!(seed32), S64.new!(seed64)
      end

      # Initializes the PRNG with initial seed.
      #
      # **@parameters**:
      # * `seed`: initial seed as input for generating the state of `prng`.
      def self.new(seed : Int)
        new S32.new!(seed), S64.new!(seed)
      end

      # Initializes the PRNG with initial seeds readed from system resources.
      def self.new
        self.secure
      end

      # Returns an instamce of this PRNG with initial seeds readed from system resources.
      def self.secure
        # Cryptographically secure PRNG
        secure = ::Random::ISAAC.new
        seed32 = secure.rand S32
        seed64 = secure.rand S64
        new seed32, seed64
      end
    end

    # Generate a uniform-distributed random `Int32` in range `Int32::MIN..Int32::MAX`.
    @[AlwaysInline]
    def next_i32 : Int32
      next_u32.to_i32!
    end

    # Generate a uniform-distributed random `Int64` in range `Int64::MIN..Int64::MAX`.
    @[AlwaysInline]
    def next_i64 : Int64
      next_u64.to_i64!
    end

    # Generate a uniform-distributed random `Float32` in `[0, 1)`.
    @[AlwaysInline]
    def next_f32 : Float32
      # 5.9604645e-8 is ldexp(1.0, -24.0).
      (next_u32 >> 8) * 5.9604645e-08f32
    end

    # Generate a uniform-distributed random `Float64` in `[0, 1)`.
    @[AlwaysInline]
    def next_f64 : Float64
      # 1.1102230246251565e-16 is ldexp(1.0, -53.0).
      (next_u64 >> 11) * 1.1102230246251565e-16f64
    end
  end
end
