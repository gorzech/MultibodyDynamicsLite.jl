using MultibodyDynamicsLite
using Test

@testset "Test for Abstract Constraints" begin
    @test KinematicConstraint <: Constraint
    @test DrivingConstraint <: Constraint
end