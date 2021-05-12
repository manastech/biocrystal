require "./rint"

module Alea
  struct Random(G)
    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, 1.0)`.
    #
    # **@references**: `#next_f64`.
    def float : Float64
      @prng.next_f64
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, max)`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `max` is negative or zero.
    def float(max : Number) : Float64
      __float64 max
    end

    # Run-time argument sanitizer for `#float`.
    private def __float64(max : Number) : Float64
      if max.class < Float
        Alea.sanity_check(max, :max, :float)
      end

      Alea.param_check(max, :<=, 0, :max, :float)

      __next_float64 max.to_f64
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0, max)`.
    # Unparsed version for `#float`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_float(max : Float64) : Float64
      __next_float64 max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, max)`.
    # Unwrapped version for `#float`.
    private def __next_float64(max : Float64) : Float64
      # Float64, excluding mantissa, has 2^53 values
      max_prec = 1u64 << 53
      __next_uint64(max_prec) / max_prec.to_f64 * max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def float(min : Number, max : Number) : Float64
      __float64 min, max
    end

    # Run-time argument sanitizer for `#float`.
    private def __float64(min : Number, max : Number) : Float64
      if min.class < Float
        Alea.sanity_check(min, :min, :float)
      end

      if max.class < Float
        Alea.sanity_check(max, :max, :float)
      end

      Alea.param_check(min, :>=, max, :min, :float)

      span = (max - min).to_f64
      __next_float64(span) + min.to_f64
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    # Unparsed version for `#float`.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_float(min : Float64, max : Float64) : Float64
      __next_float64(max - min) + min
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    #
    # **@parameters**:
    # * `range`: range parameter, inclusive or exclusive, of the distribution:
    # * `range.begin`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `range.end`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@notes**:
    # * *inclusive* means `[range.begin, range.end]`.
    # * *exclusive* means `[range.begin, range.end)`.
    # * see `Range` from Crystal stdlib.
    #
    # **@examples**:
    # ```
    # range_in = 10.0..9377.0
    # range_in # Range(Float64, Float64), end-inclusive
    #
    # range_ex = 10.0...9377.0
    # range_ex # Range(Float64, Float64), end-exclusive
    #
    # random = Alea::Random.new
    # random.float(range_in) # => 9113.861259040154
    # random.float(range_ex) # => 7701.2778313581175
    # ```
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments bound is `NaN`.
    # * `Alea::InfinityError` if any of the arguments bound is `Infinity`.
    # * `Alea::UndefinedError` if `range.end` is less than `range.begin`.
    # * `Alea::UndefinedError` if `range` is not end-inclusive but bounds are the same.
    def float(range : Range(Number, Number)) : Float64
      __float64 range
    end

    # Run-time argument sanitizer for `#float`.
    private def __float64(range : Range(Number, Number)) : Float64
      min = range.begin
      max = range.end

      if min.class < Float
        Alea.sanity_check(min, :"range.begin", :float)
      end

      if max.class < Float
        Alea.sanity_check(max, :"range.end", :float)
      end

      span = (max - min).to_f64

      if range.excludes_end?
        unless min < max
          raise Alea::UndefinedError.new "Invalid value for `float': range = #{range}"
        end
        __next_float64(span) + min.to_f64
      else
        unless min <= max
          raise Alea::UndefinedError.new "Invalid value for `float': range = #{range}"
        end
        min.to_f64 + @prng.next_f64 * span
      end
    end

    # Generate a *uniform-distributed*, pseudo-random `Float32` in range `[0.0, 1.0)`.
    #
    # **@references**: `#next_f32`.
    def float32 : Float32
      @prng.next_f32
    end

    # Generate a *uniform-distributed*, pseudo-random `Float32` in range `[0.0, max)`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `max` is negative or zero.
    def float32(max : Number) : Float32
      __float32 max
    end

    # Run-time argument sanitizer for `#float32`.
    private def __float32(max : Number) : Float32
      if max.class < Float
        Alea.sanity_check(max, :max, :float32)
      end

      Alea.param_check(max, :<=, 0, :max, :float32)

      __next_float32 max.to_f32
    end

    # Generate a *uniform-distributed*, pseudo-random `Float32` in range `[0, max)`.
    # Unparsed version for `#float32`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_float32(max : Float32) : Float32
      __next_float32 max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float32` in range `[0.0, max)`.
    # Unwrapped version for `#float32`.
    private def __next_float32(max : Float32) : Float32
      # Float32, excluding mantissa, has 2^24 values
      max_prec = 1u32 << 24
      __next_uint32(max_prec) / max_prec.to_f32 * max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float32` in fixed range.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def float32(min : Number, max : Number) : Float32
      __float32 min, max
    end

    # Run-time argument sanitizer for `#float32`.
    private def __float32(min : Number, max : Number) : Float32
      if min.class < Float
        Alea.sanity_check(min, :min, :float32)
      end

      if max.class < Float
        Alea.sanity_check(max, :max, :float32)
      end

      Alea.param_check(min, :>=, max, :min, :float32)

      span = (max - min).to_f32
      __next_float32(span) + min.to_f32
    end

    # Generate a *uniform-distributed*, pseudo-random `Float32` in fixed range.
    # Unparsed version for `#float32`.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_float32(min : Float32, max : Float32) : Float32
      __next_float32(max - min) + min
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    #
    # **@parameters**:
    # * `range`: range parameter, inclusive or exclusive, of the distribution:
    # * `range.begin`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `range.end`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@notes**:
    # * *inclusive* means `[range.begin, range.end]`.
    # * *exclusive* means `[range.begin, range.end)`.
    # * see `Range` from Crystal stdlib.
    #
    # **@examples**:
    # ```
    # range_in = 10.0..9377.0
    # range_in # Range(Float64, Float64), end-inclusive
    #
    # range_ex = 10.0...9377.0
    # range_ex # Range(Float64, Float64), end-exclusive
    #
    # random = Alea::Random.new
    # random.float32(range_in) # => 950.3449
    # random.float32(range_ex) # => 3455.0183
    # ```
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments bound is `NaN`.
    # * `Alea::InfinityError` if any of the arguments bound is `Infinity`.
    # * `Alea::UndefinedError` if `range.end` is less than `range.begin`.
    # * `Alea::UndefinedError` if `range` is not end-inclusive but bounds are the same.
    def float32(range : Range(Number, Number)) : Float32
      __float32 range
    end

    # Run-time argument sanitizer for `#float32`.
    private def __float32(range : Range(Number, Number)) : Float32
      min = range.begin
      max = range.end

      if min.class < Float
        Alea.sanity_check(min, :"range.begin", :float32)
      end

      if max.class < Float
        Alea.sanity_check(max, :"range.end", :float32)
      end

      span = (max - min).to_f32

      if range.excludes_end?
        unless min < max
          raise Alea::UndefinedError.new "Invalid value for `float32': range = #{range}"
        end
        __next_float32(span) + min.to_f32
      else
        unless min <= max
          raise Alea::UndefinedError.new "Invalid value for `float32': range = #{range}"
        end
        min.to_f32 + @prng.next_f32 * span
      end
    end
  end
end
