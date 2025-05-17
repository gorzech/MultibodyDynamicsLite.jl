
    @testset "Body constructor" begin
        @test_nowarn b1 = Body([1.0, 2.0, 3.0], [1.0, 0.0, 0.0, 0.0])
        @test_nowarn b2 = Body()
    end