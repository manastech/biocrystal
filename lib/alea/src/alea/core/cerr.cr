module Alea
  # Exception raised when distribution conditions are not met.
  class UndefinedError < Exception; end

  # Exception raised when `NaN` is passed as argument.
  class NaNError < Exception; end

  # Exception raised when `Infinity` is passed as argument.
  class InfinityError < Exception; end

  # Exception raised when algorithm has not converged within a fixed limit of iterations.
  class NoConvergeError < Exception; end

  # Compile-time expansion for sanity (NaN/Infinity) checks over arguments.
  #
  # **@parameters**:
  # * `{{x}}`: parameter to check.
  # * `{{param}}`: name of the parameter to display in exception messages.
  # * `{{caller}}`: name of the method to display in exception messages.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if `{{x}}` is `NaN`.
  # * `Alea::InfinityError` if `{{x}}` is `Infinity`.
  macro sanity_check(x, param, caller)
    if !({{x.id}} == {{x.id}})
      # NaN encountered
      raise Alea::NaNError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}}"
    elsif {{x.id}} != 0.0 && {{x.id}} * 2.0 == {{x.id}}
      # Infinity encountered
      raise Alea::InfinityError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}}"
    end
  end

  # Compile-time expansion for dist. definition checks over arguments.
  #
  # **@parameters**:
  # * `{{x}}`: parameter to check through `{{op}}` with `{{y}}`.
  # * `{{op}}`: operator that performs the comparison.
  # * `{{y}}`: parameter to check through `{{op}}` with `{{x}}`.
  # * `{{param}}`: name of the parameter to display in exception messages.
  # * `{{caller}}`: name of the method to display in exception messages.
  #
  # **@exceptions**:
  # * `Alea::UndefinedError` if `{{x}}` `{{op}}` `{{y}}` returns `true`.
  macro param_check(x, op, y, param, caller)
    if {{x.id}} {{op.id}} {{y.id}}
      # Distribution not defined under these conditions
      raise Alea::UndefinedError.new \
        "Invalid value for `{{caller.id}}': {{param.id}} = #{{{x.id}}} {{op.id}} #{{{y.id}}}"
    end
  end
end
