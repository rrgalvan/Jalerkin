module MeshTests

using Test
using Jalerkin

m = Mesh1D(0, 1, 10)
@test m.vertices ≈ [[0.1*i] for i=0:10]
@test m.cells ≈ [[i, i+1] for i=1:10]

end #module
