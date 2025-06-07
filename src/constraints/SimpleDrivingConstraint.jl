export SimpleDrivingConstraint, constraint, constraint_num, constraint_jacobian, constraint_time_derivative

struct SimpleDrivingConstraint <: DrivingConstraint
    global_index:: Int
    fun:: Function
end

SimpleDrivingConstraint(sys::MultibodySystem, body::Body, local_index::Int, fun::Function) = begin
    if length(methods(fun).ms) == 0 || any(m -> length(m.sig.parameters) != 2, methods(fun).ms)
        throw(ArgumentError("fun must be a function accepting exactly one argument"))
    end
    global_index = get_index(sys, body)[local_index]
    return SimpleDrivingConstraint(global_index, fun)
end

function constraint(c::SimpleDrivingConstraint, state::State)
    return [state.q[c.global_index] - c.fun(state.time)]
end

constraint_num(::SimpleDrivingConstraint) = 1

function constraint_jacobian(c::SimpleDrivingConstraint, state::State)
    jacobian = zeros(1, length(state.q))
    jacobian[1, c.global_index] = 1.0
    return jacobian
end

function constraint_time_derivative(c::SimpleDrivingConstraint, state::State)
    dcdt = ForwardDiff.derivative(c.fun, state.time)
end