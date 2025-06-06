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