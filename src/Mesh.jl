
#--- AbstractMesh

"""
Abastract type AbastractMesh

AstractMesh is a interface defined by overloading the following methods:

- [`get_coords(trian::Triangulation)`](@ref)
- [`get_cell_to_vertex`](trian::Triangulation)`](@ref)
"""

abstract type AbstractMesh <: JalerkinType end

"""
get_coords(Mesh::AbstractMesh) -> AbstractArray{Vector{<:Point}}}
"""
function get_coords(mesh::AbstractMesh)
    @abstractmethod
end

"""
get_cell_to_vertex(Mesh::AbstractMesh) -> AbstractArray{Vector{<:Cell}}}
"""
function get_cell_to_vertex(mesh::AbstractMesh)
    @abstractmethod
end

"""
Returns a vector with coordinates of the vertices of cell i
"""
function get_coord_of_cell(mesh, i)
    cells = get_cell_to_vertex(mesh)
    coord = get_coords(mesh)
    cell_vertex = cells[i]
    [coord[cell_vertex[1]], coord[cell_vertex[2]]]
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
@inline function get_coords(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    mesh.coord_vector
end

"""
Number of vertices in a mesh
"""
@inline function num_vertices(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    length(get_coords(mesh))
end

"""
This function is part of the interface AbstractMesh
"""
@inline function get_cell_to_vertex(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    mesh.cell_vector
end

"""
Number of cells in a mesh
"""
@inline function num_cells(mesh::Mesh{CellType, VertexType}) where {CellType, VertexType}
    length(get_cell_to_vertex(mesh))
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
