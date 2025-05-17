include("AbstractConstraints.jl")
include("MultibodySystem.jl")
include("SolverSettings.jl")
include("State.jl")

export System, make_sys, add_body!, add_constraint!, set_solver_settings

struct System
    mbs::MultibodySystem
    state::State
    settings::SolverSettings

    function System(name)
        mbs = MultibodySystem(name)
        state = State()
        settings = SolverSettings()
        new(mbs, state, settings)
    end
end

make_sys(name = "") = System(name)

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