using MultibodyDynamicsLite
using Test

@testset "Newton tests" begin
    @test_nowarn begin
        f(x) = x^2-1
        dfdx(x) = 2x
        f2(x) = 5*x*x-2*x-7 # zeros at -1, 7/5
        df2dx(x) = 5x-2
        # Test Newton's method with a simple quadratic function
        x1, iter1 = newton(f, dfdx, 10.0)
        x2, iter2 = newton(f2, df2dx, -5.0)

        @test x1 ≈ 1.0 atol=1e-10
        @test x2 ≈ -1.0 atol=1e-10
    
        settings = SolverSettings(0.0, 0.0, 0.0, 1e-6, 100)
        @test_nowarn  newton(f, dfdx, 10.0, settings)
    end
end