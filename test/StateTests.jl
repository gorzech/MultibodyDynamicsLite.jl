using Test
using MultibodyDynamicsLite

@testset "State.jl" begin
    @test_nowarn state_test = State(time = 1.0, q = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])
    @test_nowarn state_def = State()
end

@testset "Initialising state vector" begin
    bodies = [Body([0.0, 1.0, 2.0], [0.71, 0.0, 0.0, 0.71])]
    state = init_state(bodies)
    @test init_state(bodies).q[1] == 0.0
    @test init_state(bodies).q[2] == 1.0
    @test init_state(bodies).q[3] == 2.0
    @test init_state(bodies).q[4] == 0.7071067811865476
    @test init_state(bodies).q[5] == 0.0
    @test init_state(bodies).q[6] == 0.0
    @test init_state(bodies).q[7] == 0.7071067811865476
end

@testset "Testing get_index function" begin
    b1 = Body([1.0, 2.0, 3.0], [2.0, 0.0, 0.0, 0.0])
    b2 = Body([4.3, -1.0, 2.0], [2.0, 0.0, 0.0, 0.0])
    bodies = [b1, b2]
    @test get_index(bodies, b2) == 2
end