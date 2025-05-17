using Test, MultibodyDynamicsLite

@testset "SystemTests.jl" begin
    @test_nowarn test = make_sys()
end