using Test
using MultibodyDynamicsLite

@testset "State.jl" begin
    @test_nowarn state_test = State(time = 1.0, q = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])
    @test_nowarn state_def = State()
end

@testset "Initialising state vector" begin
    bodies = [Body([0.0, 1.0, 2.0], [0.71, 0.0, 0.0, 0.71])]
    @test_nowarn state = init(bodies)
    @test init(bodies).q[1] = 0.0
    @test init(bodies).q[2] = 1.0
    @test init(bodies).q[3] = 2.0
    @test init(bodies).q[4] = 1.0
end
