export Constraint, KinematicConstraint, DrivingConstraint

abstract type Constraint end

abstract type KinematicConstraint <: Constraint end

abstract type DrivingConstraint <: Constraint end