using MultibodyDynamicsLite
using Test

@testset "MultibodySystemTests.jl" begin
    @test_nowarn multibodysystem_def = MultibodySystem()
    system = MultibodySystem("test")
    @test system.name == "test"
    @test system.bodies == []
    @test system.kinematic_contstraints == []
    @test system.driving_constraints == []
end