using Test
using MultibodyDynamicsLite

@testset "State.jl" begin
    @test_nowarn state_test = State(time = 1.0, q = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])
    @test_nowarn state_def = State()
end
