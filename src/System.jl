include("AbstractConstraints.jl")
include("MultibodySystem.jl")
include("State.jl")

export System, make_sys, add_body!, add_constraint!

struct System
    mbs::MultibodySystem
    state::State
    settings::SolverSettings

    function make_sys(name = "")
        mbs = MultibodySystem(name)
        state = State()
        settings = SolverSettings()
        new(mbs, state, settings)
    end
end

function add_body(sys::System, body::Body)
    push!(sys.mbs.bodies, body)
end

function add_constraint!(sys::System, constraint::Constraint)
    if(constraint <: KinematicConstraint)
        push!(sys.mbs.kinematic_contstraints, constraint)
    elseif(constraint <: DrivingConstraint)
        push!(sys.mbs.driving_constraints, constraint)
    end
end

function set_solver_settings(sys::System, settings::SolverSettings)
    sys.settings = settings
end