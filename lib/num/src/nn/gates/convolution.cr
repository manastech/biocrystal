# Copyright (c) 2020 Crystal Data Contributors
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class Num::NN::ConvolutionGate(T) < Num::Grad::Gate(T)
  getter cached_input : Num::Grad::Variable(T)
  getter weight : Num::Grad::Variable(T)
  getter bias : Num::Grad::Variable(T)
  getter padding : Tuple(Int32, Int32)
  getter stride : Tuple(Int32, Int32)

  def initialize(
    @cached_input : Num::Grad::Variable(T),
    @weight : Num::Grad::Variable(T),
    @bias : Num::Grad::Variable(T),
    @padding : Tuple(Int32, Int32),
    @stride : Tuple(Int32, Int32)
  )
  end

  def backward(payload : Num::Grad::Payload(T)) : Array(T)
    gradient = payload.variable.grad

    r0, r1, r2 = \
       {% if flag?(:nnpack) %}
         Num::NN.conv2d_backward(
           @cached_input.value,
           @weight.value,
           @bias.value, gradient,
           @padding,
           @stride
         )
       {% elsif flag?(:im2col) %}
         Num::NN.im2colgemm_conv2d_gradient(
           @cached_input.value,
           @weight.value,
           @bias.value, gradient,
           @padding,
           @stride
         )
       {% else %}
         Num::NN.im2colgemm_conv2d_gradient(
           @cached_input.value,
           @weight.value,
           @bias.value, gradient,
           @padding,
           @stride
         )
       {% end %}

    [r0, r1, r2]
  end

  def cache(result : Num::Grad::Variable(T), *args)
    input, weight, bias, padding, stride = args

    result.grad = T.zeros_like(result.value)
    result.requires_grad = true

    Num::Grad.register("Conv", self, result, input, weight, bias)
  end
end
