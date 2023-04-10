@testset "checkversion.jl" begin
    @test isprerelease(v"0.99.5-DEV")
    @test isprerelease(v"1.2.5-Blabla")
    @test isprerelease(v"3-Blabla")
    @test !isprerelease(v"0.99.5")
    @test !isprerelease(v"1.2.5")
    @test !isprerelease(v"3")
end
