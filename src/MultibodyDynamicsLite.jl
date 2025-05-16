module MultibodyDynamicsLite
using StaticArrays

export Body6D, RevoluteJoint, assemble, step_euler!

struct Body6D
    r::SVector{3,Float64}   # position
    q::SVector{4,Float64}   # unit quaternion
    m::Float64
    Ic::SMatrix{3,3,Float64}
end

struct RevoluteJoint
    body_i::Int
    body_j::Int
    s_i::SVector{3,Float64}
    s_j::SVector{3,Float64}
end

# placeholder functions -------------------------------------------------
step!(::AbstractVector, ::AbstractVector, ::Real) = error("todo")
assemble(::Vector{Body6D}, ::Vector{RevoluteJoint}) = error("todo")

end