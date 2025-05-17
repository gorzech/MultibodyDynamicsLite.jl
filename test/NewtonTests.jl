using MultibodyDynamicsLite
using Test

@testset "Newton tests" begin
    @test_nowarn begin
        f(x) = x^2
        dfdx(x) = 2x
        x0 = 5.0
        tol = 1e-10




        x1, iter1 = newton(f, dfdx, x0, tol)
        x2, iter2 = newton(f, dfdx, x0)
       
        @test x1 == x2
        @test iter1 == iter2

        settings = SolverSettings(0.0, 0.0, 0.0, tol, 100)
        @test_nowarn  newton(f, dfdx, x0, settings)

        
    end
end



