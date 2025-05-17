using MultibodyDynamicsLite
using Test

@testset "MultibodySystemTests.jl" begin
    @test_nowarn multibodysystem_def = MultibodySystem()
end