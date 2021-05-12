require "spec"
require "../src/alea"

# default pseudo-random number generator for specs
SpecRng   = Alea::Random(Alea::XSR128).new 9377
SpecNdata = 5_000_000

AleaEngines = [
  Alea::XSR128,
  Alea::XSR256,
  Alea::MT19937,
]

def stdev(ary, mean, n)
  ans = 0.0
  ary.each do |e|
    ans += (e - mean) ** 2
  end
  Math.sqrt(ans / (n - 1))
end

# Compile-time expansion for generating parameterized specs over arguments passed to methods.
#
# **@parameters**:
# * `{{message}}`: message to display in spec messages.
# * `{{focus}}`: whether this spec is focused or not.
# * `{{pending}}`: whether this spec is pending or not.
# * `{{method}}`: the method this spec will address to.
# * `{{params}}`: NamedTuple of the (initialized) parameter(s) to be passed to `{{method}}`.
# * `{{types}}`: Array of types to be passed and checked.
# * `{{return_type}}`: the type this method should return when `{{types}}` are passed.
# * `{{caller}}`: the Object that will call `{{method}}`.
macro arg_test(message, *, focus = false, pending = false, method,
               params = nil, types, return_type, caller)
  {% begin %}
    {% if pending %}
      pending {{message}}, focus: {{focus}} do
    {% else %}
      it {{message}}, focus: {{focus}} do
    {% end %}
      {% for type in types %}
        # Update arguments passed with newly typed `1`s
        %args = {
          {% for key in params %}
            {{key.id}}: {{type}}.new(1),
          {% end %}
        }
        {{caller}}.{{method.id}}( **%args ).should be_a( {{return_type}} )
      {% end %}
      end
  {% end %}
end

# Compile-time expansion for generating sanity (NaN/Infinity) checks specs over arguments.
#
# **@parameters**:
# * `{{message}}`: message to display in spec messages.
# * `{{focus}}`: whether this/these spec(s) is/are focused or not.
# * `{{pending}}`: whether this/these spec(s) is/are pending or not.
# * `{{method}}`: the method this/these spec(s) will address to.
# * `{{params}}`: NamedTuple of the (initialized) parameter(s) to be passed to `{{method}}`.
# * `{{params_to_check}}`: Array of the parameter(s) to be sanity-checked.
# * `{{caller}}`: the Object that will call `{{method}}`.
macro sanity_test(*, focus = false, pending = false, method, params, params_to_check, caller)
  {% for param in params_to_check %}
    {% if pending %}
      pending "raises Alea::NaNError if {{param.id}} is NaN", focus: {{focus}} do
    {% else %}
      it "raises Alea::NaNError if {{param.id}} is NaN", focus: {{focus}} do
    {% end %}
        expect_raises(Alea::NaNError) do
          # Update parameter to check with NaN
          %args = {{params}}.merge({ {{param.id}}: 0.0 / 0.0 })
          # Passing default values merged with parameter to check set as NaN
          {{caller}}.{{method.id}}( **%args )
        end
      end

    {% if pending %}
      pending "raises Alea::InfinityError if {{param.id}} is Infinity", focus: {{focus}} do
    {% else %}
      it "raises Alea::InfinityError if {{param.id}} is Infinity", focus: {{focus}} do
    {% end %}
        expect_raises(Alea::InfinityError) do
          # Update parameter to check with Infinity
          %args = {{params}}.merge({ {{param.id}}: 1.0 / 0.0 })
          # Passing default values merged with parameter to check set as Infinity
          {{caller}}.{{method.id}}( **%args )
        end
      end
  {% end %}
end

# Compile-time expansion for generating parameterized specs over arguments passed to methods.
#
# **@parameters**:
# * `{{focus}}`: whether this spec(s) is/are focused or not.
# * `{{pending}}`: whether this spec(s) is/are pending or not.
# * `{{method}}`: the method this spec(s) will address to.
# * `{{params}}`: NamedTuple of the (initialized) parameter(s) to be passed to `{{method}}`.
# * `{{params_to_check}}`: Array of the parameter(s) to be sanity-checked.
# * `{{check_negatives}}`: whether this spec(s) will check for negative-valued arguments or not.
# * `{{check_zeros}}`: whether this spec(s) will check for zero-valued arguments or not.
# * `{{caller}}`: the Object that will call `{{method}}`.
macro param_test(*, focus = false, pending = false, method, params,
                 params_to_check, check_negatives, check_zeros, caller)
  {% for param in params_to_check %}
    {% if check_negatives %}
      {% if pending %}
        pending "raises Alea::UndefinedError if {{param.id}} is negative", focus: {{focus}} do
      {% else %}
        it "raises Alea::UndefinedError if {{param.id}} is negative", focus: {{focus}} do
      {% end %}
          expect_raises(Alea::UndefinedError) do
            # Update parameter to check with -1
            %type = typeof( {{params}}[{{param}}] )
            %args = {{params}}.merge({ {{param.id}}: %type.new(-1) })
            # Passing default values merged with parameter to check set as -1
            {{caller}}.{{method.id}}( **%args )
          end
        end
    {% end %}

    {% if check_zeros %}
      {% if pending %}
        pending "raises Alea::UndefinedError if {{param.id}} is zero", focus: {{focus}} do
      {% else %}
        it "raises Alea::UndefinedError if {{param.id}} is zero", focus: {{focus}} do
      {% end %}
          expect_raises(Alea::UndefinedError) do
            # Update parameter to check with 0
            %type = typeof( {{params}}[{{param}}] )
            %args = {{params}}.merge({ {{param.id}}: %type.new(0) })
            # Passing default values merged with parameter to check set as 0
            {{caller}}.{{method.id}}( **%args )
          end
        end
    {% end %}
  {% end %}
end

# Compile-time expansion for generating parameterized specs over values returned from sampling methods.
#
# **@parameters**:
# * `{{message}}`: message to display in spec messages.
# * `{{focus}}`: whether this spec is focused or not.
# * `{{pending}}`: whether this spec is pending or not.
# * `{{method}}`: the method this spec will address to.
# * `{{params}}`: NamedTuple of the (initialized) parameter(s) to be passed to `{{method}}`.
# * `{{caller}}`: the Object that will call `{{method}}`.
# * `{{samples}}`: number of samples to draw for mean and standard deviation.
# * `{{sample_type}}`: return type of `{{method}}`.
# * `{{real_mean}}`: expected value of mean from the distribution.
# * `{{real_stdev}}`: expected value of standard deviation from the distribution.
# * `{{mean_tol}}`: percent err. (of stdev) within calculated mean is expected to pass.
# * `{{stdev_tol}}`: percent err. (of stdev) within calculated stdev is expected to pass.
macro dist_test(message, *,
                focus = false, pending = false, method, params = nil,
                caller, samples = SpecNdata, sample_type,
                real_mean, real_stdev, mean_tol, stdev_tol)
  {% begin %}
    {% if pending %}
      pending {{message}}, focus: {{focus}} do
    {% else %}
      it {{message}}, focus: {{focus}} do
    {% end %}
        ary = Array({{sample_type}}).new {{samples}}
        ans = 0.0

        {{samples}}.times do
          {% if params %}
            ran = {{caller}}.{{method.id}}( **{{params}} )
          {% else %}
            ran = {{caller}}.{{method.id}}
          {% end %}
          ans += ran / {{samples}}
          ary << ran
        end

        mean = ans
        stdev = stdev(ary, mean, {{samples}})

        mean.should be_close({{real_mean}}, {{mean_tol}} * {{real_stdev}})
        stdev.should be_close({{real_stdev}}, {{stdev_tol}} * {{real_stdev}})
      end
  {% end %}
end
