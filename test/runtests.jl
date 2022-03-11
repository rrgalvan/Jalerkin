using Test

@time @testset "Mesh" begin include("MeshTests.jl") end
@time @testset "Quadrature" begin include("QuadTests.jl") end
@time @testset "LagrangeFE1D" begin include("LagrangeFE1D.jl") end
