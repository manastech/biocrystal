require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::XSR128.new
xsr256 = Alea::XSR256.new
pcg32 = Random.new

size = 10_000_000

Benchmark.ips do |x|
  x.report "PCG32#next_u" { Array(UInt32).new(size) { pcg32.next_u } }
  x.report "PCG32#rand(UInt64)" { Array(UInt64).new(size) { pcg32.rand(UInt64) } }
  x.report "XSR128#next_u" { Array(UInt64).new(size) { xsr128.next_u } }
  x.report "XSR256#next_u" { Array(UInt64).new(size) { xsr256.next_u } }
end
# ```text
#       PCG32#next_u  42.75  ( 23.39ms) (± 2.12%)  38.1MB/op        fastest
# PCG32#rand(UInt64)   7.15  (139.78ms) (± 0.53%)  76.3MB/op   5.98× slower
#      XSR128#next_u  36.05  ( 27.74ms) (± 2.08%)  76.3MB/op   1.19× slower
#      XSR256#next_u  28.13  ( 35.55ms) (± 2.92%)  76.3MB/op   1.52× slower
# ```

Benchmark.bm do |x|
  x.report "PCG32#next_u" { Array(UInt32).new(size) { pcg32.next_u } }
  x.report "PCG32#rand(UInt64)" { Array(UInt64).new(size) { pcg32.rand(UInt64) } }
  x.report "XSR128#next_u" { Array(UInt64).new(size) { xsr128.next_u } }
  x.report "XSR256#next_u" { Array(UInt64).new(size) { xsr256.next_u } }
end
# ```text
#                          user     system      total        real
# PCG32#next_u         0.026372   0.000011   0.026383 (  0.026464)
# PCG32#rand(UInt64)   0.144384   0.000001   0.144385 (  0.144537)
# XSR128#next_u        0.030734   0.000000   0.030734 (  0.030788)
# XSR256#next_u        0.039430   0.000000   0.039430 (  0.039320)
# ```

Benchmark.ips do |x|
  x.report "PCG32#next_float" { Array(Float64).new(size) { pcg32.next_float } } # alias for `rand`, 64-bit
  x.report "XSR128#next_f" { Array(Float64).new(size) { xsr128.next_f } }       # 64-bit
  x.report "XSR256#next_f" { Array(Float64).new(size) { xsr256.next_f } }       # 64-bit
end
# ```text
# PCG32#next_float  27.46  ( 36.41ms) (± 2.19%)  76.3MB/op   1.25× slower
#    XSR128#next_f  34.21  ( 29.23ms) (± 2.64%)  76.3MB/op        fastest
#    XSR256#next_f  13.39  ( 74.68ms) (± 1.54%)  76.3MB/op   2.56× slower
# ```

Benchmark.bm do |x|
  x.report "PCG32#next_float" { Array(Float64).new(size) { pcg32.next_float } }
  x.report "XSR128#next_f" { Array(Float64).new(size) { xsr128.next_f } }
  x.report "XSR256#next_f" { Array(Float64).new(size) { xsr256.next_f } }
end
# ```text
#                        user     system      total        real
# PCG32#next_float   0.039250   0.000000   0.039250 (  0.039322)
# XSR128#next_f      0.035279   0.000000   0.035279 (  0.035342)
# XSR256#next_f      0.041002   0.000000   0.041002 (  0.040916)
# ```
