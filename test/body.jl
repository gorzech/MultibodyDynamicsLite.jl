
    @testset "Body constructor" begin
        e1 = [1,2,3,4]/norm([1,2,3,4])
        @test_nowarn b1 = Body([1.0, 2.0, 3.0], e1)
        @test_nowarn b2 = Body()
    end
