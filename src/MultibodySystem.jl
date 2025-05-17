include("AbstractConstraints.jl")

export MultibodySystem

Base.@kwdef struct MultibodySystem
    bodies::Vector{Body} = []
    kinematic_contstraints::Vector{KinematicConstraint} = []
    driving_constraints::Vector{DrivingConstraint} = []
end
