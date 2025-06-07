using MultibodyDynamicsLite
using Test

@testset "Newton tests" begin
    f(x) = x^2-1
    dfdx(x) = 2x
    f2(x) = 5*x*x-2*x-7 # zeros at -1, 7/5
    dfdx2(x) = 5x-2

    @test_nowarn begin
        x, iter1 = newton(f, dfdx, 10.0)
        @test x ≈ 1.0 atol=1e-10
    end

    @test_nowarn begin
        x, iter2 = newton(f2, dfdx2, -5.0)
        @test x ≈ -1.0 atol=1e-10
    end

    @test_nowarn begin
        settings = SolverSettings(0.0, 0.0, 0.0, 1e-6, 100)
        @test_nowarn  newton(f, dfdx, 10.0, settings)
    end
end