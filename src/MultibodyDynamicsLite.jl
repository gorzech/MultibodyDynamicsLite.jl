module MultibodyDynamicsLite
using LinearAlgebra

export Body

include("AbstractConstraints.jl")

struct Body
    r::Vector{Float64}   # position x y z
    e::Vector{Float64}   # unit quaternion e0 ex ey ez
end

end