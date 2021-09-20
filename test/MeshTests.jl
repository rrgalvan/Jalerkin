module MeshTests

using Test
using Jalerkin

m = Mesh1D(0, 1, 10)

@test m.cell_vertices == [[i, i+1] for i=1:10]
@test m.vertex_coord ≈ [[0.1*i] for i=0:10]

@test get_cell_vertices(m) == [[i, i+1] for i=1:10]
@test get_vertex_coord(m) ≈ [[0.1*i] for i=0:10]


end #module
