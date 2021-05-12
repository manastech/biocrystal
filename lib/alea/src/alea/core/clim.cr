module Alea::Core
  module Limits
    # Min value within which `Math.gamma : Float64` returns non-`Infinity`.
    UNDERFLOW_MATH_GAMMA64 = 5.5626846462680059280e-309

    # Min value within which `Math.gamma : Float32` returns non-`Infinity`.
    UNDERFLOW_MATH_GAMMA32 = 2.9387365777049509324e-39f32

    # TODO:
    # Min value within which `Math.exp : Float64` returns non-`Infinity`.
    UNDERFLOW_MATH_EXP64 = 0.0e+00

    # TODO:
    # Min value within which `Math.exp : Float32` returns non-`Infinity`.
    UNDERFLOW_MATH_EXP32 = 0.0e+00

    # Max value within which `Math.gamma : Float64` returns non-`Infinity`.
    OVERFLOW_MATH_GAMMA64 = 1.716243769563027e+02

    # Max value within which `Math.gamma : Float32` returns non-`Infinity`.
    OVERFLOW_MATH_GAMMA32 = 3.504009819030761e+01

    # Max value within which `Math.exp : Float64` returns non-`Infinity`.
    OVERFLOW_MATH_EXP64 = 7.0978271289338402993e+02

    # Max value within which `Math.exp : Float32` returns non-`Infinity`.
    OVERFLOW_MATH_EXP32 = 8.8722835540771484374e+01
  end
end
