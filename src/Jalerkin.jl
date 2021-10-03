module Jalerkin
using LinearAlgebra
using StaticArrays

include("Macros.jl")
include("Mesh.jl")
include("Quadrature.jl")
include("FiniteElement.jl")
export Mesh, GenericMesh1D, Mesh1D
export get_cell_vertices, get_vertex_coord
export Quadrature, TrapezoidQuad, get_nodes, get_weights, quad, EmptyQuadrature
export FiniteElement, Lagrange, get_order, attach_quad_rule


end # module
