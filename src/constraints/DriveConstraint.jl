export DriveConstraint

struct DriveConstraint <: DriveConstraint
    global_index:: Int
    fun:: Function
end

DriveConstraint(sys::MultibodySystem, body::Body, local_index::Int, fun::Function) = begin
    if !(typeof(fun) <: Function && length(methods(fun).ms) > 0 &&
        any(m -> length(m.sig.parameters) == 2 && m.sig.parameters[2] == Float64, methods(fun).ms))
        throw(ArgumentError("fun must be a function accepting one Float64 argument"))
    end
    global_index = get_index(sys, body)[local_index]
    return DriveConstraint(global_index, fun)
end

function constraint(c::DriveConstraint, state::State)
    return [state.q[c.global_index] - c.fun(State.time)]
end

constraint_num(::DriveConstraint) = 1

function constraint_jacobian(c::DriveConstraint, state::State)
    jacobian = zeros(1, length(state.q))
    jacobian[1, c.global_index] = 1.0
    return jacobian
end

function constraint_time_derivative(c::DriveConstraint, state::State)
    dcdt = ForwardDiff.derivative(c.fun, State.time)
end