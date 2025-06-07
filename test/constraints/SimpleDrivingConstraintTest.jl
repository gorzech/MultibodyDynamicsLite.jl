using MultibodyDynamicsLite
using Test

@testset "SimpleDrivingConstraint constructor" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    add_body!(sys,body)
    
    f(t) = 2 * t^2 + t + 2

    for i = 1:7
        simple_driving_constraint = @test_nowarn SimpleDrivingConstraint(sys.mbs, body, i, f)
    end
end

@testset "SimpleDrivingConstraint constraint()" begin
    sys = make_sys()
    body = Body([1.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    add_body!(sys,body)
    f(t) = 2 * t^2 + t + 2
    q = [1.0, 1.0, 2.0, 1.0, 0.0, 0.0, 0.0]
    state = State(time = 0; q = q)
    simple_driving_constraint = SimpleDrivingConstraint(sys.mbs, body, 1, f)
    for t = 0:0.1:1
        state = State(time = t; q = q)
        @test constraint(simple_driving_constraint, state) ≈ [1.0 - (2 * t^2 + t + 2)]
    end
end

@testset "SimpleDrivingConstraint constraint_jacobian()" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    add_body!(sys,body)
    f(t) = 2 * t^2 + t + 2
    q = [0.0, 1.0, 2.0, 1.0, 0.0, 0.0, 0.0]
    state = State(time = 0; q = q)
    simple_driving_constraint = SimpleDrivingConstraint(sys.mbs, body, 1, f)
    @test_nowarn constraint_jacobian(simple_driving_constraint, state)
    @test constraint_jacobian(simple_driving_constraint, state) == [1.0 0.0 0.0 0.0 0.0 0.0 0.0]
end

@testset "SimpleDrivingConstraint constraint_time_derivative()" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    add_body!(sys,body)
    f(t) = 2 * t^2 + t + 2
    q = [0.0, 1.0, 2.0, 1.0, 0.0, 0.0, 0.0]
    state = State(time = 0; q = q)
    simple_driving_constraint = SimpleDrivingConstraint(sys.mbs, body, 1, f)
    for t = 0:0.1:1
        state = State(time = t; q = q)
        @test constraint_time_derivative(simple_driving_constraint, state) ≈ [4t + 1]
    end
end
