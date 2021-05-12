# Alea changelog

## [0.3.0]
### Added
  - **Single precision** support for all methods.
  - Exception interface:
    - `Alea::NoConvergeError`
    - `Alea::UndefinedError`
    - `Alea::InfinityError`
    - `Alea::NaNError`
  - Spec interface with macros to simplify testing:
    - `arg_test`
    - `sanity_test`
    - `param_test`
    - `dist_test`    
  - `Alea::Random`:
    - all *standard* sampling methods now accepts any-typed values.
    - **Poisson distribution** support.
  - `Alea::XSR128`, `Alea::XSR256`:
    - `UInt32` generation capabilities.
    - `new` now accepts initial states (32/64 bits) as `StaticArray`.
    - `new` now accepts initial seeds (32/64 bits) as `Int`.
    - `#jump_*` methods to advance states.
  - `Alea::CDF`:
    - all cdf methods now accepts any-typed values.
    - **Poisson distribution** support.
    - **ChiSquare distribution** support.
    - **Gamma distribution** support.
  - Modules:
    - `Alea::Core` to store internal implementations.
    - `Alea::Core::SpecFun` to store special functions implementations.
    - `Alea::Core::SpecFun::Gamma` for special gamma functions.
  - Engines:
    - `Alea::Core::SplitMix64(N)` struct for state64 initializations.
    - `Alea::Core::Mulberry32(N)` struct for state32 initializations.

### Changed
  - `Alea::Random` is now a struct.
  - Renamed all occurences of `chi_square` into `chisq`.
  - Renamed all occurences of `exponential` into `exp`.
  - Renamed all occurences of `mean` into `loc`.
  - Renamed all occurences of `freedom` into `df`.
  - Renamed `initstate` into proper `seed` in `Alea::Random.new`.
  - `Alea::CDF.chisq*` have no more default `df`.
  - `#next_u`, `#next_f` are deprecated. Now they have bit-fixed names:
    - `#next_u32 : UInt32`
    - `#next_u64 : UInt64`
    - `#next_f32 : Float32`
    - `#next_f64 : Float64`
  - `#jump` in `Alea::Random` is deprecated. Use jump method directly
    from `Alea::Random#prng` instead.
  - Unparsed sampling methods (e.g.: `#next_gamma`) now have specific
    types for arguments.

### Fixed
  - A bug causing splitmix to generate bad values.

## [0.2.3]
### Added
  - `Alea::CDF` module for Cumulative Distribution Function support.
  - Supported distributions:
    - Exponential
    - Laplace
    - Lognormal
    - Normal
    - Uniform

## [0.2.2]
### Added
  - **Uniform distribution** support.
  - New methods that take an upper limit or a range as optional arguments:
    - `Alea::Random#uint : UInt64`
    - `Alea::Random#float : Float64`

## [0.2.1]
### Added
  - **Laplace distribution** support.
  - **Safe methods**: now each sampling method has an alias for secure argument checks.
    The alias are obtained by omitting `next_` from the regular ones.

## [0.2.0]
### Changed
  - Deprecated C bindings due to the slowness of the calls to the static library.
  - Deprecated `Random::PCG32` as the main PRNG of `Alea::Random`, now powered by the `Alea::XSR128` engine by default.
  - `Alea::Random` no longer inherits the PRNG, instead it is passed to the constructor. This increases modularity and opens the doors to customizations.

### Added
  - `Alea::XSR` abstract class, inherit this to build your own PRNG to pass to `Alea::Random`.
  - `Alea::XSR128` class, PRNG loaded with a state of 128 bits.
  - `Alea::XSR256` class, PRNG loaded with a state of 256 bits.

## [0.1.1]
### Added
  - C implementations of the **xoshiro** algorithms collection for `UInt64` and `Float64` sampling.

## [0.1.0]
  - Initial release.
  - Supported distributions:
    - Normal
    - Exponential
    - Lognormal
    - Beta
    - Gamma
    - Chi Square
