module MultibodyDynamicsLite
using LinearAlgebra

include("AbstractConstraints.jl")
include("Body.jl")
include("State.jl")

<<<<<<< HEAD
export Body

include("AbstractConstraints.jl")

struct Body
    r::Vector{Float64}   # position x y z
    e::Vector{Float64}   # unit quaternion e0 ex ey ez
end

=======
>>>>>>> main
end