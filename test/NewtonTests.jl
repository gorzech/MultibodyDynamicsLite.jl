using MultibodyDynamicsLite
using Test

@testset "Newton tests" begin
    @test_nowarn begin
        f(x) = x^2
        dfdx(x) = 2x
        f2(x) = 5*x*x-2*x-7 # zeros at -1, 7/5
        df2dx(x) = 5x-2
        x0 = 2.0
        tol = 1e-10




        x1, iter1 = newton(f, dfdx, x0)
        x2, iter2 = newton(f2, df2dx, -5.0)
       
        @test x1 ≈ 0.0 atol=1e-10
  

        @test x2 ≈ -1 atol=1e-10
    


        settings = SolverSettings(0.0, 0.0, 0.0, tol, 100)
        @test_nowarn  newton(f, dfdx, x0, settings)

        
    end
end



