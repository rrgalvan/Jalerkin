
#--- AbstractMesh

"""
Abastract type AbastractMesh

AstractMesh is a interface defined by overloading the following methods:

- [`get_coord_vector(trian::Triangulation)`](@ref)
- [`get_cell_vector`](trian::Triangulation)`](@ref)
"""

abstract type AbstractMesh <: JalerkinType end

"""
get_coord_vector(Mesh::AbstractMesh) -> AbstractArray{Vector{<:Point}}}
"""
function get_coord_vector(mesh::AbstractMesh)
    @abstractmethod
end

"""
get_cell_vector(Mesh::AbstractMesh) -> AbstractArray{Vector{<:Cell}}}
"""
function get_cell_vector(mesh::AbstractMesh)
    @abstractmethod
end

#--- Mesh
"""Type Point (given dimension, type of real numbers).

Static Vector of Dim real numbers
"""
Point = SVector{Dim, fp_precision()} where {Dim}

"""Type Cell (given number of vértices)

Static vector of indices (identifiers of the cell points)
"""
Cell = SVector{NumVertex, Int64} where {NumVertex}

"""Mesh will contain sets of Cells and Vertices (Points)"""
struct Mesh{CellType, VertexType}  <: AbstractMesh
    "Vector of cells (each cell contains a list of vertex indices)"
    cell_vector :: Vector{CellType}

    "Vector of coordinates of each vertex"
    coord_vector :: Vector{VertexType}
end

"""
This function is part of the interface AbstractMesh
"""
@inline function get_coord_vector(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    mesh.coord_vector
end

"""
This function is part of the interface AbstractMesh
"""
@inline function get_cell_vector(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    mesh.cell_vector
end

"Constructor for a 1D mesh in the interval [x1, x2]"
function Mesh1D(x1, x2, ncells)
    CellType = Cell{2}
    VertexType = Point{1}
    cells = [CellType(i, i+1) for i=1:ncells]
    h = (x2-x1)/ncells
    vertices = [VertexType(x1 + h*(i-1)) for i=1:ncells+1]
    Mesh{Cell{2}, Point{1}}(cells, vertices)
end
