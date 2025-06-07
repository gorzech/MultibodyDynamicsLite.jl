using MultibodyDynamicsLite
using Test
using LinearAlgebra

include("AbstractConstraintsTests.jl")
include("BodyTests.jl")
include("Examples.jl")
include("MultibodySystemTests.jl")
include("SolverSettingsTests.jl")
include("StateTests.jl")
include("SysTests.jl")
include("VisualisatorTest.jl")
include("NewtonTests.jl")

include("constraints/SimpleDrivingConstraintTest.jl")
