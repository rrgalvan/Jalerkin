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
export get_cell_vector, get_coord_vector
export Quadrature, TrapezoidQuadrature, GaussianQuadrature
export get_nodes, get_weights, quad
export FiniteElement, Lagrange, get_order, get_mesh, get_quad_rule

end # module
