
@testset "regexprtest.jl" begin
    regrepo = "OkRegistry"
    expr1 = OkRegistrator.baseexactexpr(regrepo)
    expr0 = r"^OkRegistry$"

    @test isequal(expr1, expr0)
end
