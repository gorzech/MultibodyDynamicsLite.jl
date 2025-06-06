using Test, MultibodyDynamicsLite

@testset "SystemTests.jl" begin
    @test_nowarn test = make_sys()
    #test for setters (ADD TEST FOR CONSTRAINTS LATER)
    sys = make_sys("test")
    body = Body([0.0, 0.0, 0.0], [1.0, 0.0, 0.0, 0.0])
    body2 = Body([1.0, 1.0, 1.0], [1.0, 0.0, 0.0, 0.0])
    settings = SolverSettings(1.0,1.0,1.0,1.0,1)
    add_body!(sys, body)
    add_body!(sys, body2)
    set_solver_settings(sys, settings)
    @test sys.mbs.name == "test"
    @test sys.mbs.bodies[1] == body
    @test sys.mbs.bodies[2] == body2
    @test sys.settings == settings
end