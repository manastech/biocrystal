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

class Num::Plot::Scatter < Num::Plot::XYPlot
  @code : Int32 = 0

  # Initializes a Scatter plot
  #
  # Arguments
  # ---------
  # x
  #   Tensor like x-axis argument to plot
  # y
  #   Tensor like y-axis argument to plot
  # @color : Int32? = nil
  #   Color code to use
  # @code = 0
  #   Symbol code to use
  #
  # Examples
  # --------
  def initialize(x, y, @color : Int32? = nil, @code = 0)
    super x, y, @color
  end

  # Plots a scatter plot
  #
  # Arguments
  # ---------
  #
  # Returns
  # -------
  # nil
  #
  # Examples
  # --------
  def plot
    super
    LibPlplot.plpoin(@size, @x.to_unsafe, @y.to_unsafe, @code)
  end
end
