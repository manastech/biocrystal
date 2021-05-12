require "./src/alea"

# This is an example of custom PRNG; provide the following features to
# make it a valid extension for `Alea::Random`.
class CustomEngine
  # Include the module that provides methods and constructors: `Alea::PRNG(S32, S64)`,
  # where `S32` and `S64` will be targeted as the types of seeds and internal
  # elements of the states.
  include Alea::PRNG(UInt64, UInt64)

  # Define both your 32 and 64 bits seeds variables.
  @seed32 : UInt64
  @seed64 : UInt64

  # Define your state variables in both 32 and 64 bits.
  # NOTE: seeds must match up the type of corrisponding state.
  @state32 : StaticArray(UInt64, 4)
  @state64 : StaticArray(UInt64, 4)

  # A constructor which take both seeds as arguments is needed
  def initialize(@seed32 : UInt64, @seed64 : UInt64)
    # It is recommended to use `Alea::Core::SplitMix64` and `Alea::Core::Mulberry32`
    # to initialize 64 and 32 state bits, respectively; use `self.init_state` to
    # obtain the generated state. If you want to use them as initializers,
    # remember that they actually return `StaticArray` of unsigned integers.

    # Although @state32 is meant to generate 32-bit unsigned
    # integers, it stores 64-bit unsigned integers internally.
    # 4 is the number of integers stored: this means that this state is
    # loaded with 256 bits.
    @state32 = Alea::Core::SplitMix64(4).init_state @seed32

    # Same applies to @state64
    @state64 = Alea::Core::SplitMix64(4).init_state @seed64
  end

  # Implement the engine that generates 32-bit unisigned integers
  def next_u32 : UInt32
    # ...
  end

  # Implement the engine that generates 64-bit unisigned integers
  def next_u64 : UInt64
    # ...
  end
end

# Cryptographically secure PRNG seeded with system resources.
secure = CustomEngine.secure

# PRNG seeded by value.
seeded = CustomEngine.new 12345, 54321

# Now we are able to bind your generator to `Alea::Random` and
# make proper calls to constructors:
Alea::Random(CustomEngine).new

# (Or from an already initialized instance of a PRNG):
Alea::Random.new prng: CustomEngine.new(12345, 54321)
