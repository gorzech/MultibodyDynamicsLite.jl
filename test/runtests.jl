using MultibodyDynamicsLite
using Test
include("StateTests.jl")

@testset "MultibodyDynamicsLite.jl" begin

    @testset "Body constructor" begin
        @test_nowarn b1 = Body([1.0, 2.0, 3.0], [0.0, 0.0, 0.0, 1.0])
    end
end
