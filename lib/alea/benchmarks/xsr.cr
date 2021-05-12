require "benchmark"
require "../src/alea"

# All these results come from an Intel i3-8100 (4) @ 3.600GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::XSR128.new
xsr256 = Alea::XSR256.new
pcg32 = Random.new

Benchmark.ips(calculation: 4) do |x|
  x.report "PCG32#next_u" { pcg32.next_u }             # 32-bit
  x.report "PCG32#rand(UInt64)" { pcg32.rand(UInt64) } # 64-bit
  x.report "XSR128#next_u" { xsr128.next_u }           # 64-bit
  x.report "XSR256#next_u" { xsr256.next_u }           # 64-bit
end
# ```text
#       PCG32#next_u 510.06M (  1.96ns) (± 0.66%)  0.0B/op        fastest
# PCG32#rand(UInt64)  93.91M ( 10.65ns) (± 0.57%)  0.0B/op   5.43× slower
#      XSR128#next_u 507.08M (  1.97ns) (± 0.29%)  0.0B/op   1.01× slower
#      XSR256#next_u 428.08M (  2.34ns) (± 0.28%)  0.0B/op   1.19× slower
# ```

Benchmark.bm do |x|
  x.report "PCG32#next_u" { pcg32.next_u }
  x.report "PCG32#rand(UInt64)" { pcg32.rand(UInt64) }
  x.report "XSR128#next_u" { xsr128.next_u }
  x.report "XSR256#next_u" { xsr256.next_u }
end
# ```text
#                          user     system      total        real
# PCG32#next_u         0.000002   0.000000   0.000002 (  0.000001)
# PCG32#rand(UInt64)   0.000001   0.000000   0.000001 (  0.000001)
# XSR128#next_u        0.000001   0.000000   0.000001 (  0.000001)
# XSR256#next_u        0.000001   0.000000   0.000001 (  0.000001)
# ```

Benchmark.ips(calculation: 4) do |x|
  x.report "PCG32#next_float" { pcg32.next_float } # alias for `rand`, 64-bit
  x.report "XSR128#next_f" { xsr128.next_f }       # 64-bit
  x.report "XSR256#next_f" { xsr256.next_f }       # 64-bit
end
# ```text
# PCG32#next_float 512.39M (  1.95ns) (± 0.16%)  0.0B/op        fastest
#    XSR128#next_f 507.35M (  1.97ns) (± 0.16%)  0.0B/op   1.01× slower
#    XSR256#next_f 424.98M (  2.35ns) (± 0.25%)  0.0B/op   1.21× slower
# ```

Benchmark.bm do |x|
  x.report "PCG32#next_float" { pcg32.next_float }
  x.report "XSR128#next_f" { xsr128.next_f }
  x.report "XSR256#next_f" { xsr256.next_f }
end
# ```text
#                        user     system      total        real
# PCG32#next_float   0.000002   0.000000   0.000002 (  0.000001)
# XSR128#next_f      0.000001   0.000000   0.000001 (  0.000001)
# XSR256#next_f      0.000001   0.000000   0.000001 (  0.000001)
# ```
