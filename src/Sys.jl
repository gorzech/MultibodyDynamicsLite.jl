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


function solve_kinematics(sys::System, s0::State)   
    # Solve the kinematic constraints using Newton's method
    function f(x) 
        return constraint(sys, State(time = s0.time, q = x))
    end
    
    function dfdx(x)
        return dfdx(x) = ForwardDiff.jacobian(f, x) 
    end
         
    results   = newton(f, dfdx, s0.q, sys.solver_settings)
    
    return State(time=s0.time, q=results)

end