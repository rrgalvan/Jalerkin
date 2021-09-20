
abstract type AbstractQuadrature end;

struct Quadrature{N, T} <: AbstractQuadrature
    """
    Trapezoid with N nodes and weights of type T
    """
    nodes :: SVector{N, T}
    weights :: SVector{N, T}
end

@inline function nodes(q::Quadrature{N,T}) where {N,T}
    q.nodes
end

@inline function weights(q::Quadrature{N,T}) where {N,T}
    q.weights
end

function TrapezoidQuad()
    """
    Trapezoid quadrature rule on interval [0, 1]
    """
    nodes = [0, 1]
    weights = [0.5, 0.5]
    Quadrature{2,Float64}(nodes, weights)
end

function quad(values :: AbstractArray, q::Quadrature{N,T}) where {N,T}
    """
    Compute integral of a function using a concrete quadrature formula,
    where 'values' are the values of the function on q.nodes
    """
    dot(weights(q), values)
end

@inline function quad(f, q::Quadrature{N,T}) where {N,T}
    """
    Compute integral of a function using a concrete quadrature formula
    """
    quad(f.(nodes(q)))
end
