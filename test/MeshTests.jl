module MeshTests

using Test
using Jalerkin

p = Point{2}(0,0)
@test p == [0,0]

c = Cell{2}(1,2)
@test c == [1,2]

# 1D mesh
m = Mesh1D(0, 1, 10)
@test num_vertices(m) == 11
@test num_cells(m) == 10
@test get_cell_to_vertex(m) == [[i, i+1] for i=1:10]
@test get_coords(m) ≈ [[0.1*i] for i=0:10]

# Quadrangular 2D mesh
C = Cell{4}
P = Point{2}
m = Mesh{C,P}( [C(1,2,3,4), C(3,4,5,6)],
        [P(0,0),P(0,1), P(0.5,0),P(0.5,1), P(1,0),P(1,1)])

end # module
