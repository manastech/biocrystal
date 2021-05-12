module Alea::Core
  # `SplitMix64(N)` generator to initialize a `N` sized state for the pseudo-random number generators.
  # NOTE: `N` refers to the size in bits of the state divided by 64.
  #
  # The algorithm comes from http://prng.di.unimi.it/splitmix64.c.
  #
  # ```
  # state = Alea::Core::SplitMix64(2).init_state 93u64
  # state # => StaticArray[17266415801915045436, 2250649230797539417]
  # ```
  struct SplitMix64(N)
    # Written in 2015 by Sebastiano Vigna (vigna@acm.org)
    #
    # To the extent possible under law, the author has dedicated all copyright
    # and related and neighboring rights to this software to the public domain
    # worldwide. This software is distributed without any warranty.
    #
    # See <http://creativecommons.org/publicdomain/zero/1.0/>.

    # Generate a state to be used by PRNGs as a `StaticArray(UInt64, N)`.
    #
    # **@parameters**:
    # * `seed`: initial seed; it must be an `UInt64`.
    def self.init_state(seed : UInt64)
      StaticArray(UInt64, N).new do
        tmp = (seed &+= 0x9e3779b97f4a7c15)
        tmp = (tmp ^ (tmp >> 30)) &* 0xbf58476d1ce4e5b9
        tmp = (tmp ^ (tmp >> 27)) &* 0x94d049bb133111eb
        tmp ^ (tmp >> 31)
      end
    end
  end

  # `Mulberry32(N)` generator to initialize a `N` sized state for the pseudo-random number generators.
  # NOTE: `N` refers to the size in bits of the state divided by 32.
  #
  # The algorithm comes from https://gist.github.com/tommyettinger/46a874533244883189143505d203312c.
  #
  # ```
  # state = Alea::Core::Mulberry32(4).init_state 93u32
  # state # => StaticArray[1079867279, 1912516084, 2459043021, 3508473169]
  # ```
  struct Mulberry32(N)
    # Written in 2017 by Tommy Ettinger (tommy.ettinger@gmail.com)
    #
    # To the extent possible under law, the author has dedicated all copyright
    # and related and neighboring rights to this software to the public domain
    # worldwide. This software is distributed without any warranty.
    #
    # See <http://creativecommons.org/publicdomain/zero/1.0/>.

    # Generate a state to be used by PRNGs as a `StaticArray(UInt32, N)`.
    #
    # **@parameters**:
    # * `seed`: initial seed; it must be an `UInt32`.
    def self.init_state(seed : UInt32)
      StaticArray(UInt32, N).new do
        tmp = (seed &+= 0x6d2b79f5u32)
        tmp = (tmp ^ (tmp >> 15)) &* (tmp | 1u32)
        tmp ^= tmp &+ (tmp ^ (tmp >> 7)) &* (tmp | 61u32)
        tmp ^ (tmp >> 14)
      end
    end
  end

  # Knuth32(N)` generator to initialize a `N` sized state for the pseudo-random number generators.
  # NOTE: `N` refers to the size in bits of the state divided by 32.
  #
  # The algorithm comes from https://github.com/numpy/numpy/blob/master/numpy/random/src/mt19937/mt19937.c.
  #
  # ```
  # state = Alea::Core::Knuth32(4).init_state 93u32
  # state # => StaticArray[93, 1052567986, 1433826620, 220522004]
  # ```
  struct Knuth32(N)
    # Generate a state to be used by PRNGs as a `StaticArray(UInt32, N)`.
    #
    # **@parameters**:
    # * `seed`: initial seed; it must be an `UInt32`.
    def self.init_state(seed : UInt32)
      seed &= 0xffffffffu32
      StaticArray(UInt32, N).new do |i|
        tmp = seed
        seed = (1812433253u32 &* (seed ^ (seed >> 30)) &+ i &+ 1)
        seed &= 0xffffffffu32
        tmp
      end
    end
  end
end
