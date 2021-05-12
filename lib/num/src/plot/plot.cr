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

class Num::Plot::Plot
  # Class method to faciliate plotting of generic plots
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
  def self.plot
    plotter = Num::Plot::Options.new
    plotter.tap do |instance|
      with instance yield
    end

    if !plotter.term.nil?
      LibPlplot.plsdev(plotter.term.to_s)
    end

    palette = Num::Plot::COLOR_MAPS[plotter.palette]

    LibPlplot.plspal0(palette)
    LibPlplot.plinit

    b = plotter.bounds
    LibPlplot.plenv(b.x_min, b.x_max, b.y_min, b.y_max, 0, 0)
    LibPlplot.pllab(plotter.x_label, plotter.y_label, plotter.label)

    plotter.figures.each_with_index do |fig, i|
      LibPlplot.plcol0(i + 1)
      fig.plot
    end

    LibPlplot.plend
  end
end
