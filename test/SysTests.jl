using MultibodyDynamicsLite
using Test

@testset "Sys functions: make_sys()" begin
    sys = @test_nowarn make_sys()
    @test sys isa System
    @test sys.mbs isa MultibodySystem
    @test sys.state isa State
    @test sys.solver_settings isa SolverSettings
end

@testset "Sys functions: add_body()" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    sys = @test_nowarn add_body!(sys, body)
    @test length(sys.mbs.bodies) == 1
    @test length(sys.state.q) == 7
    @test sys.state.q ≈ [0.0, 1.0, 2.0, 1.0, 0.0, 0.0, 0.0]
end

@testset "Sys functions: add_constraint()" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    sys = add_body!(sys, body)
    c_fixed = FixedConstraint(sys.mbs, body, 1, 0.0)
    
    sys = @test_nowarn add_constraint!(sys, c_fixed)
    @test length(sys.mbs.kinematic_contstraints) == 1
    @test length(sys.mbs.driving_constraints) == 0
    @test sys.mbs.kinematic_contstraints[1] === c_fixed
end

@testset "Sys functions: set_sovler_settings()" begin
    @test_nowarn fal
end

@testset "Sys functions: solve(sys)" begin
    @test_nowarn false
end


