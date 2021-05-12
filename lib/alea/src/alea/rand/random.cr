require "./rgen/prng"
require "./*"

module Alea
  # `Alea::Random` provides the interface for pseudo-random generations and distribution sampling.
  #
  # NOTE: due to [this](https://github.com/crystal-lang/crystal/issues/4678), you still need
  # to specify the generator as the generic type, as it does not accept a default one.
  #
  # ```
  # seed = 9377
  # random = Alea::Random(Alea::XSR128).new(seed)
  # random.float # => 0.08153691876972058
  #
  # # Passing an instance of a PRNG:
  # xsr = Alea::XSR256.new 9377, 2353
  # random = Alea::Random.new xsr
  # random.prng # => Alea::XSR256
  # ```
  #
  # As long as it includes the `Alea::PRNG` module, you can build your own generator: check
  # out the [example](https://github.com/nin93/alea/blob/master/custom_prng.cr) provided in
  # the documentation to make it a valid extension for `Alea::Random`.
  #
  # The following implementations are taken from **numpy**.
  struct Random(G)
    # The PRNG in use by this struct.
    getter prng : G

    # Initializes the PRNG with initial instance.
    #
    # NOTE: due to [this](https://github.com/crystal-lang/crystal/issues/4678), you still need
    # to specify the generator as the generic type, as it does not accept a default one.
    #
    # **@parameters**:
    # * `prng`: the PRNG instance itself.
    def initialize(@prng : G)
    end

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators of `prng`.
    # * `seed64`: value as input to init. the state of 64-bit generators of `prng`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def self.new(seed32 : Int, seed64 : Int)
      Alea.param_check(seed32, :<, 0, :seed32, :"Random.new")
      Alea.param_check(seed64, :<, 0, :seed64, :"Random.new")
      new G.new(seed32, seed64)
    end

    # Initializes the PRNG with initial seed.
    #
    # **@parameters**:
    # * `seed`: initial seed as input for generating the state of `prng`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if `seed` is negative.
    def self.new(seed : Int)
      Alea.param_check(seed, :<, 0, :seed, :"Random.new")
      new G.new(seed, seed)
    end

    # Initializes the PRNG with initial state readed from system resources.
    def self.new
      new G.secure
    end

    # Returns the next generated `Int32`.
    def next_i32 : Int32
      @prng.next_i32
    end

    # Returns the next generated `Int64`.
    def next_i64 : Int64
      @prng.next_i64
    end

    # Returns the next generated `UInt32`.
    def next_u32 : UInt32
      @prng.next_u32
    end

    # Returns the next generated `UInt64`.
    def next_u64 : UInt64
      @prng.next_u64
    end

    # Returns the next generated `Float32`.
    def next_f32 : Float32
      @prng.next_f32
    end

    # Returns the next generated `Float64`.
    def next_f64 : Float64
      @prng.next_f64
    end
  end
end
