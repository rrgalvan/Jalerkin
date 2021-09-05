using StaticArrays

"""Type Point (given dimension, type of real numbers).

Static Vector of Dim real numbers (for type T)
"""
Point = SVector{Dim, T} where {Dim, T <: Real}

"""Type Cell (given number of vértices)

Static vector of indices (identifiers of the cell points)
"""
Cell = SVector{Nv, Int64} where Nv

"""Mesh will contain sets of Cells and Vertices (Points)"""
struct Mesh{CellType, VertexType}
    cells :: Vector{CellType}
    vertices :: Vector{VertexType}
end

"1D mesh whose points are defined by a generic type (e.g. Float64)"
GenericMesh1D = Mesh{Cell{2}, Point{1,T}} where T

"Constructor for generic 1D mesh in the interval [x1, x2]"
function GenericMesh1D{T}(x1, x2, ncells) where {T}
    CellType = Cell{2}
    VertexType = Point{1, T}
    cells = [CellType(i, i+1) for i=1:ncells]
    h = (x2-x1)/ncells
    vertices = [VertexType(x1 + h*(i-1)) for i=1:ncells+1]
    GenericMesh1D{T}(cells, vertices)
end

"Constructor for meshes with Float64 vertices"
Mesh1D(x1, x2, ncells) = GenericMesh1D{Float64}(x1, x2, ncells)
