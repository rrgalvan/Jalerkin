module Jalerkin

using LinearAlgebra
using StaticArrays

include("Definitions.jl")
include("Macros.jl")
include("Mesh.jl")
include("Quadrature.jl")
include("FiniteElement.jl")

export fp_precision
export Mesh, GenericMesh1D, Mesh1D, Point, Cell
export get_cell_to_vertex, get_coords
export Quadrature, TrapezoidQuadrature, GaussianQuadrature
export get_nodes, get_weights, quad
export FiniteElement, Lagrange, get_order, num_local_dofs, get_mesh
export get_quad_rule, get_phi, get_JxW

end # module
