using MultibodyDynamicsLite
using Test

@testset "Sys functions: make_sys()" begin
    sys = @test_nowarn make_sys()
    @test sys isa System
    @test sys.mbs isa MultibodySystem
    @test sys.init_state isa State
    @test sys.solver_settings isa SolverSettings
end

@testset "Sys functions: add_body()" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    sys = @test_nowarn add_body!(sys, body)
    @test length(sys.mbs.bodies) == 1
    @test length(sys.init_state.q) == 7
    @test sys.init_state.q ≈ [0.0, 1.0, 2.0, 1.0, 0.0, 0.0, 0.0]
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
    sys = make_sys()
    settings = SolverSettings()
    sys = @test_nowarn set_solver_settings!(sys, settings)
    @test sys.solver_settings === settings
end

@testset "Sys functions: constraint(sys)" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    sys = add_body!(sys, body)

    c_fixed1 = FixedConstraint(sys.mbs, body, 1, 0.0)
    sys = add_constraint!(sys, c_fixed1)
    c_fixed2 = FixedConstraint(sys.mbs, body, 2, 1.0)
    sys = add_constraint!(sys, c_fixed2)
    c_fixed3 = FixedConstraint(sys.mbs, body, 3, 2.0)
    sys = add_constraint!(sys, c_fixed3)
    c_fixed4 = FixedConstraint(sys.mbs, body, 4, 1.0)
    sys = add_constraint!(sys, c_fixed4)
    c_fixed5 = FixedConstraint(sys.mbs, body, 5, 0.0)
    sys = add_constraint!(sys, c_fixed5)
    c_fixed6 = FixedConstraint(sys.mbs, body, 6, 0.0)
    sys = add_constraint!(sys, c_fixed6)
    c_fixed7 = FixedConstraint(sys.mbs, body, 7, 0.0)
    sys = add_constraint!(sys, c_fixed7)
    
    constraints_result = constraint(sys, sys.init_state)
    @test length(constraints_result) == 7
    @test norm(constraints_result) ≈ 0.0
end

@testset "Sys functions: constraint(sys)" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    sys = add_body!(sys, body)

    c_fixed1 = FixedConstraint(sys.mbs, body, 1, 0.0)
    sys = add_constraint!(sys, c_fixed1)
    c_fixed2 = FixedConstraint(sys.mbs, body, 2, 0.0)
    sys = add_constraint!(sys, c_fixed2)
    c_fixed3 = FixedConstraint(sys.mbs, body, 3, 0.0)
    sys = add_constraint!(sys, c_fixed3)
    c_fixed4 = FixedConstraint(sys.mbs, body, 4, 1.0)
    sys = add_constraint!(sys, c_fixed4)
    c_fixed5 = FixedConstraint(sys.mbs, body, 5, 0.0)
    sys = add_constraint!(sys, c_fixed5)
    c_fixed6 = FixedConstraint(sys.mbs, body, 6, 0.0)
    sys = add_constraint!(sys, c_fixed6)
    c_fixed7 = FixedConstraint(sys.mbs, body, 7, 0.0)
    sys = add_constraint!(sys, c_fixed7)
    
    constraints_result = constraint(sys, sys.init_state)
    @test length(constraints_result) == 7
    @test constraints_result[1] == 0.0
    @test constraints_result[2] == 1.0
    @test constraints_result[3] == 2.0
    @test constraints_result[4] == 0.0
    @test constraints_result[5] == 0.0
    @test constraints_result[6] == 0.0
    @test constraints_result[7] == 0.0
end

@testset "Sys functions: constraint_jacobian(sys)" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    sys = add_body!(sys, body)

    c_fixed1 = FixedConstraint(sys.mbs, body, 1, 0.0)
    sys = add_constraint!(sys, c_fixed1)
    c_fixed2 = FixedConstraint(sys.mbs, body, 2, 1.0)
    sys = add_constraint!(sys, c_fixed2)
    c_fixed3 = FixedConstraint(sys.mbs, body, 3, 2.0)
    sys = add_constraint!(sys, c_fixed3)
    c_fixed4 = FixedConstraint(sys.mbs, body, 4, 1.0)
    sys = add_constraint!(sys, c_fixed4)
    c_fixed5 = FixedConstraint(sys.mbs, body, 5, 0.0)
    sys = add_constraint!(sys, c_fixed5)
    c_fixed6 = FixedConstraint(sys.mbs, body, 6, 0.0)
    sys = add_constraint!(sys, c_fixed6)
    c_fixed7 = FixedConstraint(sys.mbs, body, 7, 0.0)
    sys = add_constraint!(sys, c_fixed7)

    jacobian_result = constraint_jacobian(sys, sys.init_state)
    @test size(jacobian_result) == (7, 7)
    @test norm(jacobian_result - I) ≈ 0.0
end


