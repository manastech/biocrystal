require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::Random.new Alea::XSR128
xsr256 = Alea::Random.new Alea::XSR256

size = 10_000_000

Benchmark.ips do |x|
  x.report "XSR128#chi_square(1)" { Array(Float64).new(size) { xsr128.chi_square 2.0 } }
  x.report "XSR128#next_chi_square(1)" { Array(Float64).new(size) { xsr128.next_chi_square 2.0 } }

  x.report "XSR256#chi_square(1)" { Array(Float64).new(size) { xsr256.chi_square 2.0 } }
  x.report "XSR256#next_chi_square(1)" { Array(Float64).new(size) { xsr256.next_chi_square 2.0 } }
end
# ```text
#      XSR128#chi_square(1)   9.57  (104.48ms) (± 0.92%)  76.3MB/op        fastest
# XSR128#next_chi_square(1)   9.53  (104.96ms) (± 1.35%)  76.3MB/op   1.00× slower
#      XSR256#chi_square(1)   8.92  (112.13ms) (± 1.39%)  76.3MB/op   1.07× slower
# XSR256#next_chi_square(1)   8.90  (112.30ms) (± 1.47%)  76.3MB/op   1.07× slower
# ```

Benchmark.bm do |x|
  x.report "XSR128#chi_square(1)" { Array(Float64).new(size) { xsr128.chi_square 2.0 } }
  x.report "XSR128#next_chi_square(1)" { Array(Float64).new(size) { xsr128.next_chi_square 2.0 } }

  x.report "XSR256#chi_square(1)" { Array(Float64).new(size) { xsr256.chi_square 2.0 } }
  x.report "XSR256#next_chi_square(1)" { Array(Float64).new(size) { xsr256.next_chi_square 2.0 } }
end
# ```text
#                                 user     system      total        real
# XSR128#chi_square(1)        0.106082   0.000000   0.106082 (  0.106171)
# XSR128#next_chi_square(1)   0.106030   0.000002   0.106032 (  0.106149)
# XSR256#chi_square(1)        0.114216   0.000000   0.114216 (  0.114314)
# XSR256#next_chi_square(1)   0.114932   0.000000   0.114932 (  0.115083)
# ```
