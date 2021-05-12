require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::Random.new Alea::XSR128
xsr256 = Alea::Random.new Alea::XSR256

size = 10_000_000

Benchmark.ips do |x|
  x.report "XSR128#exponential(0)" { Array(Float64).new(size) { xsr128.exponential } }
  x.report "XSR128#exponential(1)" { Array(Float64).new(size) { xsr128.exponential 2.0 } }

  x.report "XSR128#next_exponential(0)" { Array(Float64).new(size) { xsr128.next_exponential } }
  x.report "XSR128#next_exponential(1)" { Array(Float64).new(size) { xsr128.next_exponential 2.0 } }

  x.report "XSR256#exponential(0)" { Array(Float64).new(size) { xsr256.exponential } }
  x.report "XSR256#exponential(1)" { Array(Float64).new(size) { xsr256.exponential 2.0 } }

  x.report "XSR256#next_exponential(0)" { Array(Float64).new(size) { xsr256.next_exponential } }
  x.report "XSR256#next_exponential(1)" { Array(Float64).new(size) { xsr256.next_exponential 2.0 } }
end
# ```text
#      XSR128#exponential(0)   9.61  (104.07ms) (± 1.10%)  76.3MB/op   1.00× slower
#      XSR128#exponential(1)   9.57  (104.46ms) (± 0.82%)  76.3MB/op   1.00× slower
# XSR128#next_exponential(0)   9.61  (104.05ms) (± 1.09%)  76.3MB/op        fastest
# XSR128#next_exponential(1)   9.57  (104.54ms) (± 1.26%)  76.3MB/op   1.00× slower
#      XSR256#exponential(0)   8.98  (111.41ms) (± 1.17%)  76.3MB/op   1.07× slower
#      XSR256#exponential(1)   8.94  (111.82ms) (± 0.99%)  76.3MB/op   1.07× slower
# XSR256#next_exponential(0)   9.00  (111.13ms) (± 0.77%)  76.3MB/op   1.07× slower
# XSR256#next_exponential(1)   8.96  (111.63ms) (± 0.95%)  76.3MB/op   1.07× slower
# ```

Benchmark.bm do |x|
  x.report "XSR128#exponential(0)" { Array(Float64).new(size) { xsr128.exponential } }
  x.report "XSR128#exponential(1)" { Array(Float64).new(size) { xsr128.exponential 2.0 } }

  x.report "XSR128#next_exponential(0)" { Array(Float64).new(size) { xsr128.next_exponential } }
  x.report "XSR128#next_exponential(1)" { Array(Float64).new(size) { xsr128.next_exponential 2.0 } }

  x.report "XSR256#exponential(0)" { Array(Float64).new(size) { xsr256.exponential } }
  x.report "XSR256#exponential(1)" { Array(Float64).new(size) { xsr256.exponential 2.0 } }

  x.report "XSR256#next_exponential(0)" { Array(Float64).new(size) { xsr256.next_exponential } }
  x.report "XSR256#next_exponential(1)" { Array(Float64).new(size) { xsr256.next_exponential 2.0 } }
end
# ```text
#                                  user     system      total        real
# XSR128#exponential(0)        0.105349   0.000008   0.105357 (  0.105821)
# XSR128#exponential(1)        0.109193   0.000000   0.109193 (  0.109244)
# XSR128#next_exponential(0)   0.105432   0.000000   0.105432 (  0.105559)
# XSR128#next_exponential(1)   0.106114   0.000001   0.106115 (  0.106209)
# XSR256#exponential(0)        0.113251   0.000001   0.113252 (  0.113417)
# XSR256#exponential(1)        0.113046   0.000002   0.113048 (  0.113032)
# XSR256#next_exponential(0)   0.115441   0.000000   0.115441 (  0.115612)
# XSR256#next_exponential(1)   0.114152   0.000000   0.114152 (  0.114236)
# ```
