using Test
using MultibodyDynamicsLite

@testset "SolverSettings Constructor" begin
    # Test default constructor
    s = SolverSettings()
    @test s.start_time_s == 0.0
    @test s.end_time_s == 1.0
    @test s.time_step_s == 0.01
    @test s.max_tolerance == 1e-6
    @test s.max_iterations == 100
end

@testset "SolverSettings Custom Values" begin
    # Test custom values
    s2 = SolverSettings(2.0, 5.0, 0.1, 1e-8, 50)
    @test s2.start_time_s == 2.0
    @test s2.end_time_s == 5.0
    @test s2.time_step_s == 0.1
    @test s2.max_tolerance == 1e-8
    @test s2.max_iterations == 50
end

@testset "SolverSettings Partial Custom Values" begin
    # Test partial custom values (using defaults for others)
    s3 = SolverSettings(start_time_s = 1.0, end_time_s = 2.0)
    @test s3.start_time_s == 1.0
    @test s3.end_time_s == 2.0
    @test s3.time_step_s == 0.01
    @test s3.max_tolerance == 1e-6
    @test s3.max_iterations == 100
end

@testset "SolverSettings Type Enforcement" begin
    # Test type enforcement
    @test_throws MethodError SolverSettings("0", 1.0, 0.01, 1e-6, 100)
    @test_throws MethodError SolverSettings(0.0, 1.0, 0.01, 1e-6, "100")
end