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

Mesh1D = Mesh{Cell{2}, Point{1,T}} where T

"Constructor for 1D mesh in the interval [x1, x2]"
function Mesh1D{T}(x1::Real, x2::Real, ncells::Signed) where {T}
    CellType = Cell{2}
    VertexType = Point{1, T}
    cells = [CellType(i, i+1) for i=1:ncells]
    h = (x2-x1)/ncells
    vertices = [VertexType(x1 + h*(i-1)) for i=1:ncells+1]
    Mesh1D{T}(cells, vertices)
end
