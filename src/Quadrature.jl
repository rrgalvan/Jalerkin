
abstract type AbstractQuadrature end;


#--- Quadrature
struct Quadrature{N, T} <: AbstractQuadrature
    """
    Quadrature rule with N nodes and weights of type T
    """
    nodes :: SVector{N, T}
    weights :: SVector{N, T}
end

@inline function get_nodes(q::Quadrature{N,T}) where {N,T}
    q.nodes
end

@inline function get_weights(q::Quadrature{N,T}) where {N,T}
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

@inline function quad(q::Quadrature{N,T}, values::AbstractArray) where {N,T}
    """
    Compute integral of a function using a concrete quadrature rule,
    where 'values' are the values of the function on q.nodes
    """
    get_weights(q) ⋅ values
end

@inline function quad(q::Quadrature{N,T}, f) where {N,T}
    """
    Compute integral of a function using a concrete quadrature formula
    """
    quad(q, f.(get_nodes(q)))
end


#--- EmptyQuadrature
struct EmptyQuadrature <: AbstractQuadrature end
@inline get_nodes(q::EmptyQuadrature) = []
@inline get_weights(q::EmptyQuadrature) = []
