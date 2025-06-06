export System, make_sys, add_body!, add_constraint!, set_solver_settings!, constraint


mutable struct System
    mbs::MultibodySystem
    init_state::State
    solver_settings::SolverSettings
end

function make_sys() 
    mbs = MultibodySystem()
    state = init_state(mbs.bodies)
    solver_settings = SolverSettings()
    return System(mbs, state, solver_settings)
end

function add_body!(sys::System, body::Body)
    push!(sys.mbs.bodies, body)
    sys.init_state = init_state(sys.mbs.bodies)
    return sys
end

function add_constraint!(sys::System, constraint::KinematicConstraint)
    push!(sys.mbs.kinematic_contstraints, constraint)
    return sys
end

function add_constraint!(sys::System, constraint::DrivingConstraint)
    push!(sys.mbs.driving_constraints, constraint)
    return sys
end

function set_solver_settings!(sys::System, settings::SolverSettings)
    sys.solver_settings = settings
    return sys
end

function constraint(sys::System, state::State)
    result = Float64[]
    for c in sys.mbs.kinematic_contstraints
        append!(result, constraint(c, state))
    end
    for c in sys.mbs.driving_constraints
        append!(result, constraint(c, state))
    end
    return result
end

# function constraint_jacobian(sys::System)


#     F = begin
        
#     end


#     ForwardDiff.jacobian(
#         q -> constraint(sys, State(q)),
#         sys.state.q
#     )

# end