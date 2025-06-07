module MultibodyDynamicsLite
using ForwardDiff
using LinearAlgebra

include("AbstractConstraints.jl")
include("Body.jl")

include("MultibodySystem.jl")
include("State.jl")
include("SolverSettings.jl")
include("Newton.jl") # must be after SolverSettings

include("Sys.jl")
include("Visualiser.jl")

include("constraints/FixedConstraint.jl")
include("constraints/SimpleDrivingConstraint.jl")

end
