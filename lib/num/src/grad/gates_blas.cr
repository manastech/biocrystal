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

# :nodoc:
class Num::Grad::MatMulGate(T) < Num::Grad::Gate(T)
  getter a : Num::Grad::Variable(T)
  getter b : Num::Grad::Variable(T)

  # :nodoc:
  def initialize(@a : Num::Grad::Variable(T), @b : Num::Grad::Variable(T))
  end

  # :nodoc:
  def backward(payload : Num::Grad::Payload(T)) : Array(T)
    gradient = payload.variable.grad

    r0 = gradient.matmul(@b.value.transpose)
    r1 = @a.value.transpose.matmul(gradient)

    [r0, r1]
  end

  # :nodoc:
  def cache(result : Num::Grad::Variable(T), *args)
    a, b = args

    result.grad = T.zeros_like(result.value)
    result.requires_grad = true

    Num::Grad.register("MatMul", self, result, a, b)
  end
end