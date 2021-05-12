require "./cblas"

@[Link("fftw3")]
lib LibFFTW
  alias Integer = LibC::Int
  alias Real = LibC::Float
  alias Double = LibC::Double
  alias Logical = LibC::Char
  alias Ftnlen = LibC::Int
  alias LFp = Pointer(Void)
  alias UInt = LibC::SizeT

  type FfftwPlan = Void*
  type FftwComplex = Double[2]

  fun fftw_plan_dft_r2c_1d(n0 : Integer, in : Double*, outp : LibCblas::ComplexDouble*, flags : UInt) : FfftwPlan
  fun fftw_plan_dft_c2r_1d(n0 : Integer, in : LibCblas::ComplexDouble*, outp : Double*, flags : UInt) : FfftwPlan

  fun fftw_plan_dft_r2c_2d(n0 : Integer, n1 : Integer, in : Double*, outp : LibCblas::ComplexDouble*, flags : UInt) : FfftwPlan
  fun fftw_plan_dft_c2r_2d(n0 : Integer, n1 : Integer, in : LibCblas::ComplexDouble*, outp : Double*, flags : UInt) : FfftwPlan

  fun fftw_plan_dft_r2c_3d(n0 : Integer, n1 : Integer, n2 : Integer, in : Double*, outp : FftwComplex*, flags : UInt) : FfftwPlan

  fun fftw_plan_dft_1d(n0 : Integer, in : LibCblas::ComplexDouble*, outp : LibCblas::ComplexDouble*, flags : UInt) : FfftwPlan

  fun fftw_plan_dft_r2c(rank : Integer, n : Integer*, in : Double*, outp : LibCblas::ComplexDouble*, flags : UInt) : FfftwPlan
  fun fftw_plan_dft_c2r(rank : Integer, n : Integer*, in : LibCblas::ComplexDouble*, outp : Double*, flags : UInt) : FfftwPlan

  fun fftw_execute(plan : FfftwPlan)
  fun fftw_execute_dft_r2c(plan : FfftwPlan, in : Double*, outp : LibCblas::ComplexDouble*)
  fun fftw_execute_dft_c2r(plan : FfftwPlan, in : LibCblas::ComplexDouble*, outp : Double*)

  fun fftw_execute_dft(plan : FfftwPlan, in : LibCblas::ComplexDouble*, outp : LibCblas::ComplexDouble*)
  fun fftw_destroy_plan(plan : FfftwPlan)
end
