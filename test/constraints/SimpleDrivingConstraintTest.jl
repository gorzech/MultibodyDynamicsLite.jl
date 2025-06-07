using MultibodyDynamicsLite
using Test

@testset "SimpleDrivingConstraintTest.jl" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [1.0, 0.0, 0.0, 0.0])
    add_body!(sys,body)
    
    f(t) = 2cos(t) + sin(t) + 2

    for i = 1:7
        simple_driving_constraint = @test_nowarn SimpleDrivingConstraint(sys.mbs, body, i, f)
        con = @test_nowarn constraint(simple_driving_constraint, sys.init_state)
        @test con ≈ [sys.init_state.q[i] - 4]
        jacobian = @test_nowarn constraint_jacobian(simple_driving_constraint, sys.init_state)
        z = zeros(1,7)
        z[1,i] = 1.0
        @test jacobian == z
        dt = @test_nowarn constraint_time_derivative(simple_driving_constraint, sys.init_state)
        @test dt ≈ 1.0
    end

    
    

end