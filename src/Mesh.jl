
#--- AbstractMesh

"""
Abastract type AbastractMesh

AstractMesh is a interface defined by overloading the following methods:

- [`get_vertex_coord(trian::Triangulation)`](@ref)
- [`get_cell_vertices`](trian::Triangulation)`](@ref)
"""

abstract type AbstractMesh <: JalerkinType end

"""
get_vertex_coordinates(Mesh::AbstractMesh) -> AbstractArray{Vector{<:Point}}}
"""
function get_vertex_coord(mesh::AbstractMesh)
    @abstractmethod
end

"""
get_cell_vertices(Mesh::AbstractMesh) -> AbstractArray{Vector{<:Cell}}}
"""
function get_cell_vertices(mesh::AbstractMesh)
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
Cell = SVector{Nv, Int64} where {Nv}

"""Mesh will contain sets of Cells and Vertices (Points)"""
struct Mesh{CellType, VertexType}  <: AbstractMesh
    cell_vertices :: Vector{CellType}
    vertex_coord :: Vector{VertexType}
end

"""
This function is part of the interface AbstractMesh
"""
@inline function get_vertex_coord(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    mesh.vertex_coord
end

"""
This function is part of the interface AbstractMesh
"""
@inline function get_cell_vertices(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    mesh.cell_vertices
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
