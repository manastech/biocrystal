require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::Random.new Alea::XSR128
xsr256 = Alea::Random.new Alea::XSR256

size = 10_000_000

Benchmark.ips do |x|
  x.report "XSR128#normal(0)" { Array(Float64).new(size) { xsr128.normal } }
  x.report "XSR128#normal(1)" { Array(Float64).new(size) { xsr128.normal 2.0 } }
  x.report "XSR128#normal(2)" { Array(Float64).new(size) { xsr128.normal 2.0, 0.5 } }

  x.report "XSR128#next_normal(0)" { Array(Float64).new(size) { xsr128.next_normal } }
  x.report "XSR128#next_normal(1)" { Array(Float64).new(size) { xsr128.next_normal 2.0 } }
  x.report "XSR128#next_normal(2)" { Array(Float64).new(size) { xsr128.next_normal 2.0, 0.5 } }

  x.report "XSR256#normal(0)" { Array(Float64).new(size) { xsr256.normal } }
  x.report "XSR256#normal(1)" { Array(Float64).new(size) { xsr256.normal 2.0 } }
  x.report "XSR256#normal(2)" { Array(Float64).new(size) { xsr256.normal 2.0, 0.5 } }

  x.report "XSR256#next_normal(0)" { Array(Float64).new(size) { xsr256.next_normal } }
  x.report "XSR256#next_normal(1)" { Array(Float64).new(size) { xsr256.next_normal 2.0 } }
  x.report "XSR256#next_normal(2)" { Array(Float64).new(size) { xsr256.next_normal 2.0, 0.5 } }
end
# ```text
#      XSR128#normal(0)   9.78  (102.23ms) (± 1.03%)  76.3MB/op   1.00× slower
#      XSR128#normal(1)   9.67  (103.38ms) (± 3.37%)  76.3MB/op   1.01× slower
#      XSR128#normal(2)   9.58  (104.36ms) (± 1.04%)  76.3MB/op   1.02× slower
# XSR128#next_normal(0)   9.81  (101.98ms) (± 1.27%)  76.3MB/op        fastest
# XSR128#next_normal(1)   9.76  (102.51ms) (± 1.20%)  76.3MB/op   1.01× slower
# XSR128#next_normal(2)   9.36  (106.83ms) (± 0.97%)  76.3MB/op   1.05× slower
#      XSR256#normal(0)   9.24  (108.21ms) (± 1.25%)  76.3MB/op   1.06× slower
#      XSR256#normal(1)   9.25  (108.11ms) (± 0.90%)  76.3MB/op   1.06× slower
#      XSR256#normal(2)   8.99  (111.18ms) (± 0.76%)  76.3MB/op   1.09× slower
# XSR256#next_normal(0)   9.23  (108.32ms) (± 1.02%)  76.3MB/op   1.06× slower
# XSR256#next_normal(1)   9.25  (108.11ms) (± 1.00%)  76.3MB/op   1.06× slower
# XSR256#next_normal(2)   8.99  (111.28ms) (± 0.89%)  76.3MB/op   1.09× slower
# ```

Benchmark.bm do |x|
  x.report "XSR128#normal(0)" { Array(Float64).new(size) { xsr128.normal } }
  x.report "XSR128#normal(1)" { Array(Float64).new(size) { xsr128.normal 2.0 } }
  x.report "XSR128#normal(2)" { Array(Float64).new(size) { xsr128.normal 2.0, 0.5 } }

  x.report "XSR128#next_normal(0)" { Array(Float64).new(size) { xsr128.next_normal } }
  x.report "XSR128#next_normal(1)" { Array(Float64).new(size) { xsr128.next_normal 2.0 } }
  x.report "XSR128#next_normal(2)" { Array(Float64).new(size) { xsr128.next_normal 2.0, 0.5 } }

  x.report "XSR256#normal(0)" { Array(Float64).new(size) { xsr256.normal } }
  x.report "XSR256#normal(1)" { Array(Float64).new(size) { xsr256.normal 2.0 } }
  x.report "XSR256#normal(2)" { Array(Float64).new(size) { xsr256.normal 2.0, 0.5 } }

  x.report "XSR256#next_normal(0)" { Array(Float64).new(size) { xsr256.next_normal } }
  x.report "XSR256#next_normal(1)" { Array(Float64).new(size) { xsr256.next_normal 2.0 } }
  x.report "XSR256#next_normal(2)" { Array(Float64).new(size) { xsr256.next_normal 2.0, 0.5 } }
end
# ```text
#                             user     system      total        real
# XSR128#normal(0)        0.102670   0.000000   0.102670 (  0.102817)
# XSR128#normal(1)        0.105249   0.000000   0.105249 (  0.105296)
# XSR128#normal(2)        0.105908   0.000000   0.105908 (  0.106040)
# XSR128#next_normal(0)   0.103599   0.000000   0.103599 (  0.103545)
# XSR128#next_normal(1)   0.103658   0.000000   0.103658 (  0.103760)
# XSR128#next_normal(2)   0.106062   0.000000   0.106062 (  0.106061)
# XSR256#normal(0)        0.112988   0.000000   0.112988 (  0.113319)
# XSR256#normal(1)        0.109604   0.000000   0.109604 (  0.109665)
# XSR256#normal(2)        0.114674   0.000000   0.114674 (  0.114977)
# XSR256#next_normal(0)   0.110150   0.000002   0.110152 (  0.110436)
# XSR256#next_normal(1)   0.110349   0.000000   0.110349 (  0.110540)
# XSR256#next_normal(2)   0.113309   0.000000   0.113309 (  0.113253)
# ```
