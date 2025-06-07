using MultibodyDynamicsLite
using Test


@testset "Newton scalar equation" begin
    f(x) = x^2-1
    dfdx(x) = 2x
    @test_nowarn begin
        x, iter1 = newton(f, dfdx, 10.0)
        @test x ≈ 1.0 atol=1e-6
    end
end

@testset "Newton vector equation" begin
    F(x) = [5*x*x-2*x-7]
    J(x) = [10*x - 2]
    @test_nowarn begin
        x, iter1 = newton(F, J, 10.0)
        @test x ≈ 1.4 atol=1e-6
    end
end

@testset "Newton solver setting" begin
    f(x) = [x[1]^2 - 1, x[2]^2 - 4]
    dfdx(x) = [2*x[1] 0; 0 2*x[2]]
    settings = SolverSettings(0.0, 0.0, 0.0, 1e-6, 2)
        x, iter = newton(f, dfdx, [1.0, 1.0], settings)
        @test iter == 2
end