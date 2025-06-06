export FixedConstraint

struct FixedConstraint <: KinematicConstraint
    global_index:: Int
    value:: Float64
end

FixedConstraint(sys::MultibodySystem, body::Body, local_index::Int, value::Float64) = begin
    global_index = get_index(sys, body)[local_index]
    return FixedConstraint(global_index, value)
end

function constraint(c::FixedConstraint, state::State)
    return [state.q[c.global_index] - c.value]
end

constraint_num(::FixedConstraint) = 1

function constraint_jacobian(c::FixedConstraint, state::State)
    jacobian = zeros(1, length(state.q))
    jacobian[1, c.global_index] = 1.0
    return jacobian
end