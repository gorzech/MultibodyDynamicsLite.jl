using Test
using MultibodyDynamicsLite

@testset "State.jl" begin
    @test_nowarn state_test = State([1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], 0.1)
end
