using MultibodyDynamicsLite
using Test

@testset "Sys solve_kinematics" begin
    sys = make_sys()
    body = Body([0.0, 1.0, 2.0], [0.71, 0.71, 0.0, 0.0])
    sys = add_body!(sys, body)

    c_driving1 = SimpleDrivingConstraint(sys.mbs, body, 1, t -> sin(2 * π * t))
    sys = add_constraint!(sys, c_driving1)
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

    result = solve_kinematics(sys)

    @test length(result) == 101

    for i in 1:101
        @test result[i].time ≈ 0.01 * (i - 1)
        @test result[i].q[1] ≈ sin(2 * π * result[i].time)

        v = velocity(sys, result[i])
        @test v[1] ≈ -2 * π * cos(2 * π * result[i].time)
    end

    draw_frame(sys, result)
end