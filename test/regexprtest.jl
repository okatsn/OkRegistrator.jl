
@testset "regexprtest.jl" begin
    regrepo = "OkRegistry"
    expr1 = OkRegistrator.regrepoexpr(regrepo)
    expr0 = r"^((?!OkRegistry).)*$"
    r"^((?!OkRegistry).)*$"

    @test isequal(expr1, expr0)
end
