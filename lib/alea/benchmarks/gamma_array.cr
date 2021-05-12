require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::Random.new Alea::XSR128
xsr256 = Alea::Random.new Alea::XSR256

size = 10_000_000

Benchmark.ips do |x|
  x.report "XSR128#gamma(1)" { Array(Float64).new(size) { xsr128.gamma 2.0 } }
  x.report "XSR128#gamma(2)" { Array(Float64).new(size) { xsr128.gamma 2.0, 0.5 } }

  x.report "XSR128#next_gamma(1)" { Array(Float64).new(size) { xsr128.next_gamma 2.0 } }
  x.report "XSR128#next_gamma(2)" { Array(Float64).new(size) { xsr128.next_gamma 2.0, 0.5 } }

  x.report "XSR256#gamma(1)" { Array(Float64).new(size) { xsr256.gamma 2.0 } }
  x.report "XSR256#gamma(2)" { Array(Float64).new(size) { xsr256.gamma 2.0, 0.5 } }

  x.report "XSR256#next_gamma(1)" { Array(Float64).new(size) { xsr256.next_gamma 2.0 } }
  x.report "XSR256#next_gamma(2)" { Array(Float64).new(size) { xsr256.next_gamma 2.0, 0.5 } }
end
# ```text
#      XSR128#gamma(1)   4.86  (205.72ms) (± 0.70%)  76.3MB/op        fastest
#      XSR128#gamma(2)   4.76  (210.21ms) (± 0.97%)  76.3MB/op   1.02× slower
# XSR128#next_gamma(1)   4.84  (206.76ms) (± 0.64%)  76.3MB/op   1.01× slower
# XSR128#next_gamma(2)   4.81  (207.91ms) (± 0.74%)  76.3MB/op   1.01× slower
#      XSR256#gamma(1)   4.60  (217.21ms) (± 0.78%)  76.3MB/op   1.06× slower
#      XSR256#gamma(2)   4.60  (217.51ms) (± 0.67%)  76.3MB/op   1.06× slower
# XSR256#next_gamma(1)   4.56  (219.46ms) (± 1.37%)  76.3MB/op   1.07× slower
# XSR256#next_gamma(2)   4.52  (221.37ms) (± 0.42%)  76.3MB/op   1.08× slower
# ```

Benchmark.bm do |x|
  x.report "XSR128#gamma(1)" { Array(Float64).new(size) { xsr128.gamma 2.0 } }
  x.report "XSR128#gamma(2)" { Array(Float64).new(size) { xsr128.gamma 2.0, 0.5 } }

  x.report "XSR128#next_gamma(1)" { Array(Float64).new(size) { xsr128.next_gamma 2.0 } }
  x.report "XSR128#next_gamma(2)" { Array(Float64).new(size) { xsr128.next_gamma 2.0, 0.5 } }

  x.report "XSR256#gamma(1)" { Array(Float64).new(size) { xsr256.gamma 2.0 } }
  x.report "XSR256#gamma(2)" { Array(Float64).new(size) { xsr256.gamma 2.0, 0.5 } }

  x.report "XSR256#next_gamma(1)" { Array(Float64).new(size) { xsr256.next_gamma 2.0 } }
  x.report "XSR256#next_gamma(2)" { Array(Float64).new(size) { xsr256.next_gamma 2.0, 0.5 } }
end
# ```text
#                            user     system      total        real
# XSR128#gamma(1)        0.208835   0.000000   0.208835 (  0.208944)
# XSR128#gamma(2)        0.208715   0.000000   0.208715 (  0.208785)
# XSR128#next_gamma(1)   0.207747   0.000000   0.207747 (  0.207853)
# XSR128#next_gamma(2)   0.210245   0.000001   0.210246 (  0.210138)
# XSR256#gamma(1)        0.219061   0.000000   0.219061 (  0.219217)
# XSR256#gamma(2)        0.222488   0.000000   0.222488 (  0.222357)
# XSR256#next_gamma(1)   0.218089   0.000001   0.218090 (  0.218216)
# XSR256#next_gamma(2)   0.216056   0.000000   0.216056 (  0.215922)
# ```
