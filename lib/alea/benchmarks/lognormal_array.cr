require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::Random.new Alea::XSR128
xsr256 = Alea::Random.new Alea::XSR256

size = 10_000_000

Benchmark.ips do |x|
  x.report "XSR128#lognormal(0)" { Array(Float64).new(size) { xsr128.lognormal } }
  x.report "XSR128#lognormal(1)" { Array(Float64).new(size) { xsr128.lognormal 2.0 } }
  x.report "XSR128#lognormal(2)" { Array(Float64).new(size) { xsr128.lognormal 2.0, 0.5 } }

  x.report "XSR128#next_lognormal(0)" { Array(Float64).new(size) { xsr128.next_lognormal } }
  x.report "XSR128#next_lognormal(1)" { Array(Float64).new(size) { xsr128.next_lognormal 2.0 } }
  x.report "XSR128#next_lognormal(2)" { Array(Float64).new(size) { xsr128.next_lognormal 2.0, 0.5 } }

  x.report "XSR256#lognormal(0)" { Array(Float64).new(size) { xsr256.lognormal } }
  x.report "XSR256#lognormal(1)" { Array(Float64).new(size) { xsr256.lognormal 2.0 } }
  x.report "XSR256#lognormal(2)" { Array(Float64).new(size) { xsr256.lognormal 2.0, 0.5 } }

  x.report "XSR256#next_lognormal(0)" { Array(Float64).new(size) { xsr256.next_lognormal } }
  x.report "XSR256#next_lognormal(1)" { Array(Float64).new(size) { xsr256.next_lognormal 2.0 } }
  x.report "XSR256#next_lognormal(2)" { Array(Float64).new(size) { xsr256.next_lognormal 2.0, 0.5 } }
end
# ```text
#      XSR128#lognormal(0)   4.38  (228.39ms) (± 2.91%)  76.3MB/op   1.04× slower
#      XSR128#lognormal(1)   4.48  (223.17ms) (± 0.90%)  76.3MB/op   1.01× slower
#      XSR128#lognormal(2)   4.38  (228.43ms) (± 1.00%)  76.3MB/op   1.04× slower
# XSR128#next_lognormal(0)   4.53  (220.63ms) (± 0.48%)  76.3MB/op        fastest
# XSR128#next_lognormal(1)   4.47  (223.72ms) (± 0.71%)  76.3MB/op   1.01× slower
# XSR128#next_lognormal(2)   4.35  (229.75ms) (± 1.81%)  76.3MB/op   1.04× slower
#      XSR256#lognormal(0)   4.31  (231.80ms) (± 2.93%)  76.3MB/op   1.05× slower
#      XSR256#lognormal(1)   4.40  (227.28ms) (± 0.62%)  76.3MB/op   1.03× slower
#      XSR256#lognormal(2)   4.30  (232.57ms) (± 0.69%)  76.3MB/op   1.05× slower
# XSR256#next_lognormal(0)   4.47  (223.77ms) (± 0.52%)  76.3MB/op   1.01× slower
# XSR256#next_lognormal(1)   4.38  (228.11ms) (± 0.70%)  76.3MB/op   1.03× slower
# XSR256#next_lognormal(2)   4.29  (232.86ms) (± 0.62%)  76.3MB/op   1.06× slower
# ```

Benchmark.bm do |x|
  x.report "XSR128#lognormal(0)" { Array(Float64).new(size) { xsr128.lognormal } }
  x.report "XSR128#lognormal(1)" { Array(Float64).new(size) { xsr128.lognormal 2.0 } }
  x.report "XSR128#lognormal(2)" { Array(Float64).new(size) { xsr128.lognormal 2.0, 0.5 } }

  x.report "XSR128#next_lognormal(0)" { Array(Float64).new(size) { xsr128.next_lognormal } }
  x.report "XSR128#next_lognormal(1)" { Array(Float64).new(size) { xsr128.next_lognormal 2.0 } }
  x.report "XSR128#next_lognormal(2)" { Array(Float64).new(size) { xsr128.next_lognormal 2.0, 0.5 } }

  x.report "XSR256#lognormal(0)" { Array(Float64).new(size) { xsr256.lognormal } }
  x.report "XSR256#lognormal(1)" { Array(Float64).new(size) { xsr256.lognormal 2.0 } }
  x.report "XSR256#lognormal(2)" { Array(Float64).new(size) { xsr256.lognormal 2.0, 0.5 } }

  x.report "XSR256#next_lognormal(0)" { Array(Float64).new(size) { xsr256.next_lognormal } }
  x.report "XSR256#next_lognormal(1)" { Array(Float64).new(size) { xsr256.next_lognormal 2.0 } }
  x.report "XSR256#next_lognormal(2)" { Array(Float64).new(size) { xsr256.next_lognormal 2.0, 0.5 } }
end
# ```text
#                                user     system      total        real
# XSR128#lognormal(0)        0.221402   0.000000   0.221402 (  0.222081)
# XSR128#lognormal(1)        0.224338   0.000000   0.224338 (  0.225263)
# XSR128#lognormal(2)        0.227100   0.000000   0.227100 (  0.227608)
# XSR128#next_lognormal(0)   0.219208   0.000000   0.219208 (  0.219985)
# XSR128#next_lognormal(1)   0.221395   0.000000   0.221395 (  0.222063)
# XSR128#next_lognormal(2)   0.228982   0.000000   0.228982 (  0.229648)
# XSR256#lognormal(0)        0.226429   0.000000   0.226429 (  0.227188)
# XSR256#lognormal(1)        0.227616   0.000000   0.227616 (  0.228610)
# XSR256#lognormal(2)        0.232902   0.000000   0.232902 (  0.233511)
# XSR256#next_lognormal(0)   0.223536   0.000000   0.223536 (  0.224328)
# XSR256#next_lognormal(1)   0.228484   0.000000   0.228484 (  0.229293)
# XSR256#next_lognormal(2)   0.231964   0.000000   0.231964 (  0.232544)
# ```
