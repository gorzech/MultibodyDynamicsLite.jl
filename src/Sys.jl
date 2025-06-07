export System, make_sys, add_body!, add_constraint!, set_solver_settings!, constraint, constraint_jacobian, solve_kinematics


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

function constraint_jacobian(sys::System, state::State)
    equation_count = 0
    if !isempty(sys.mbs.kinematic_contstraints)
        equation_count += sum(constraint_num(c) for c in sys.mbs.kinematic_contstraints)
    end
    if !isempty(sys.mbs.driving_constraints)
        equation_count += sum(constraint_num(c) for c in sys.mbs.driving_constraints)
    end

    jacobian = zeros(equation_count, length(state.q))
    offset = 0
    for c in sys.mbs.kinematic_contstraints
        n = constraint_num(c)
        jacobian[offset .+ (1:n), :] = constraint_jacobian(c, state)
        offset += n
    end

    for c in sys.mbs.driving_constraints
        n = constraint_num(c)
        jacobian[offset .+ (1:n), :] = constraint_jacobian(c, state)
        offset += n
    end
    return jacobian
end


function solve_kinematics(sys::System, s0::State, time::Float64) 
    F(q) = constraint(sys, State(time=time, q=q))
    J(q) = constraint_jacobian(sys, State(time=time, q=q))
    q, iter = newton(F, J, copy(s0.q), sys.solver_settings)
    return State(time=time, q=q)
end

function solve_kinematics(sys::System)
    t = sys.solver_settings.start_time_s:sys.solver_settings.time_step_s:sys.solver_settings.end_time_s
    n = length(t)

    states = State[]
    state = solve_kinematics(sys, sys.init_state, t[1])
    push!(states, state)

    for i in 2:n
        state = solve_kinematics(sys, state, t[i])
        push!(states, state)
    end

    return states
end



