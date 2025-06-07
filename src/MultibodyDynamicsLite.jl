module MultibodyDynamicsLite
using ForwardDiff
using LinearAlgebra

include("AbstractConstraints.jl")
include("Body.jl")

include("MultibodySystem.jl")
include("SolverSettings.jl")
include("Newton.jl") # must be after SolverSettings
include("State.jl")
include("Sys.jl")

include("constraints/FixedConstraint.jl")

end
