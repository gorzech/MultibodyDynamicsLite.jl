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
    @test_nowarn false
end

@testset "Sys functions: add_constraint()" begin
    @test_nowarn false
end

@testset "Sys functions: set_sovler_settings()" begin
    @test_nowarn false
end

@testset "Sys functions: solve(sys)" begin
    @test_nowarn false
end


