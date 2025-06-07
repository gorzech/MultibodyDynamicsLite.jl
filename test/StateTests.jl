using Test
using MultibodyDynamicsLite
import MultibodyDynamicsLite: Rq, G, Gwq_local, Gqw_local, Gwq_global, Gqw_global

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
    sys = MultibodySystem()
    b1 = Body([1.0, 2.0, 3.0], [2.0, 0.0, 0.0, 0.0])
    b2 = Body([4.3, -1.0, 2.0], [2.0, 0.0, 0.0, 0.0])
    push!(sys.bodies, b1)
    push!(sys.bodies, b2)
    @test get_index(sys, b2) == 8:14
end

@testset "Testing Rq function" begin
    q_local = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0]
    R = Rq(q_local)
    @test R ≈ [
        1.0 0.0 0.0;
        0.0 1.0 0.0;
        0.0 0.0 1.0
    ]
end

@testset "Testing Rq function X rotation" begin
    rot = cos(π/4)
    q_local = [0.0, 0.0, 0.0, rot, rot, 0.0, 0.0]
    R = Rq(q_local)
    @test R ≈ [
        1.0 0.0  0.0;
        0.0 0.0 -1.0;
        0.0 1.0  0.0
    ]
end

@testset "Testing Rq function Y rotation" begin
    rot = cos(π/4)
    q_local = [0.0, 0.0, 0.0, rot, 0.0, rot, 0.0]
    R = Rq(q_local)
    @test R ≈ [
        0.0 0.0 1.0;
        0.0 1.0 0.0;
        -1.0 0.0 0.0
    ]
end

@testset "Testing Rq function Z rotation" begin
    rot = cos(π/4)
    q_local = [0.0, 0.0, 0.0, rot, 0.0, 0.0, rot]
    R = Rq(q_local)
    @test R ≈ [
        0.0 -1.0 0.0;
        1.0  0.0 0.0;
        0.0  0.0 1.0
    ]
end

@testset "Testing G function property" begin
    e = [1.0, 0.0, 0.0, 0.0]
    G_val = @test_nowarn G(e)
    
    @test (G_val * G_val') ≈ I(3)
    @test (G_val' * G_val) ≈ I(4) - e * e'
end

@testset "Testing Gwq_local" begin
    q_local = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0]
    Gwq = Gwq_local(q_local)
    @test Gwq[1:3, 1:3] ≈ I(3)
end

@testset "Testing Gqw_local" begin
    q_local = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0]
    Gqw = Gqw_local(q_local)
    @test Gqw[1:3, 1:3] ≈ I(3)
end

@testset "Testing Gwq_global" begin
    r = [0.0, 1.0, 2.0]
    e = [0.71, 0.0, 0.0, 0.71]
    bodies = [Body(r, e)]
    state = init_state(bodies)
    Gwq = Gwq_global(state)
    @test Gwq[1:3, 1:3] ≈ I(3)
    @test Gwq ≈ Gwq_local(state.q[1:7])
end

@testset "Testing Gqw_global" begin
    r = [0.0, 1.0, 2.0]
    e = [0.71, 0.0, 0.0, 0.71]
    bodies = [Body(r, e)]
    state = init_state(bodies)
    Gqw = Gqw_global(state)
    @test Gqw[1:3, 1:3] ≈ I(3)
    @test Gqw ≈ Gqw_local(state.q[1:7])
end