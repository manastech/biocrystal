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

class Num::NN::SGDOptimizer(T) < Num::NN::Optimizer(T)
  getter params : Array(Num::Grad::Variable(T))
  getter learning_rate : Float64

  def initialize(@learning_rate : Float64)
    @params = [] of Num::Grad::Variable(T)
  end

  def build_params(l : Array(Layer(T)))
    l.each do |layer|
      layer.variables.each do |v|
        @params << v
      end
    end
  end

  def update
    @params.each do |v|
      if v.requires_grad
        v.value.map!(v.grad) do |x, y|
          x - @learning_rate * y
        end
        v.grad = T.zeros_like(v.value)
      end
    end
  end
end

class Num::NN::SGDMomentumOptimizer(T) < Num::NN::Optimizer(T)
  getter params : Array(Num::Grad::Variable(T))
  getter learning_rate : Float64
  getter momentum : Float64
  getter moments : Array(T)
  getter decay : Float64
  getter nesterov : Bool

  def initialize(
    @learning_rate : Float64,
    @momentum : Float64 = 0.0,
    @decay : Float64 = 0.0,
    @nesterov : Bool = false
  )
    @params = [] of Num::Grad::Variable(T)
    @moments = [] of T
  end

  def build_params(l : Array(Layer(T)))
    l.each do |layer|
      layer.variables.each do |v|
        @params << v
        @moments << T.zeros_like(v.grad)
      end
    end
  end

  def update
    @learning_rate *= 1 / (@decay + 1)
    @decay += @decay

    @params.size.times do |i|
      v = @params[i]

      if v.requires_grad
        @moments[i].map!(v.grad) do |x, y|
          @momentum * x - @learning_rate * y
        end

        if @nesterov
          v.value.map!(v.grad, @moments[i]) do |x, y, z|
            x - @learning_rate * y + @momentum * z
          end
        else
          v.value.map!(@moments[i]) do |x, y|
            x + y
          end
        end

        v.grad = T.zeros_like(v.value)
      end
    end
  end
end

class Num::NN::AdamOptimizer(T) < Num::NN::Optimizer(T)
  getter params : Array(Num::Grad::Variable(T))
  getter learning_rate : Float64
  getter beta1 : Float64
  getter beta2 : Float64
  getter beta1_t : Float64
  getter beta2_t : Float64
  getter first_moments : Array(T)
  getter second_moments : Array(T)
  getter epsilon : Float64

  def initialize(
    @learning_rate : Float64 = 0.001,
    @beta1 : Float64 = 0.9,
    @beta2 : Float64 = 0.999,
    @epsilon : Float64 = 1e-8
  )
    @params = [] of Num::Grad::Variable(T)
    @beta1_t = @beta1
    @beta2_t = @beta2

    @first_moments = [] of T
    @second_moments = [] of T
  end

  def build_params(l : Array(Layer(T)))
    l.each do |layer|
      layer.variables.each do |v|
        @params << v
        @first_moments << T.zeros_like(v.grad)
        @second_moments << T.zeros_like(v.grad)
      end
    end
  end

  def update
    lr_t = @learning_rate * Math.sqrt(1 - @beta2_t) / (1 - @beta1_t)

    @beta1_t *= @beta1
    @beta2_t *= @beta2

    @params.size.times do |i|
      v = @params[i]

      if v.requires_grad
        @first_moments[i].map!(v.grad) do |x, y|
          @beta1 * x + (1 - @beta1) * y
        end

        @second_moments[i].map!(v.grad) do |x, y|
          @beta2 * x + (1 - @beta2) * y * y
        end

        v.value.map!(@first_moments[i], @second_moments[i]) do |x, y, z|
          x - lr_t * y / (Math.sqrt(z) + @epsilon)
        end

        v.grad = T.zeros_like(v.value)
      end
    end
  end
end
