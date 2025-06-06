export MultibodySystem

struct MultibodySystem
    name::String
    bodies::Vector{Body}
    kinematic_contstraints::Vector{KinematicConstraint}
    driving_constraints::Vector{DrivingConstraint}

    function MultibodySystem(name = "")
        new(name, [], [], [])
    end
end
