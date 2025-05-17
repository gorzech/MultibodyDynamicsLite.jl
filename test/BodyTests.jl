using MultibodyDynamicsLite
using Test

@testset "Body constructor default" begin
    @test_nowarn begin
        b1 = Body()
        @test b1.r == [0.0, 0.0, 0.0]
        @test b1.e == [1.0, 0.0, 0.0, 0.0]
    end
end

@testset "Body constructor normalization" begin
    @test_throws ArgumentError Body([1.0, 2.0, 3.0], [0.0, 0.0, 0.0, 0.0])

    @test_nowarn begin
        b3 = Body([1.0, 2.0, 3.0], [2.0, 0.0, 0.0, 0.0])
        @test b3.r == [1.0, 2.0, 3.0]
        @test b3.e == [1.0, 0.0, 0.0, 0.0]
    end
end

