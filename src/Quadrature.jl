using FastGaussQuadrature

abstract type AbstractQuadrature end;


#--- Quadrature
struct Quadrature{N} <: AbstractQuadrature
    """
    Quadrature rule with N nodes and weights of type T
    """
    nodes :: SVector{N, fp_precision()}
    weights :: SVector{N, fp_precision()}
end

@inline function get_nodes(q::AbstractQuadrature)
    q.nodes
end

@inline function get_weights(q::AbstractQuadrature)
    q.weights
end

@inline function quad(q::AbstractQuadrature, values::AbstractArray)
    """
    Compute integral of a function using a concrete quadrature rule,
    where 'values' are the values of the function on q.nodes
    """
    get_weights(q) ⋅ values
end

@inline function quad(q::AbstractQuadrature, f)
    """
    Compute integral of a function using a concrete quadrature formula
    """
    quad(q, f.(get_nodes(q)))
end

#--- Constructors for concrete quadrature rules


function GaussianQuadrature(n)
    nodes, weights = gausslegendre(n)
    Quadrature{n}(nodes, weights)
end

function TrapezoidQuadrature()
    """
    Trapezoid quadrature rule on interval [0, 1]
    """
    nodes = [0, 1]
    weights = [0.5, 0.5]
    Quadrature{2}(nodes, weights)
end


#--- EmptyQuadrature
struct EmptyQuadrature <: AbstractQuadrature end
@inline get_nodes(q::EmptyQuadrature) = []
@inline get_weights(q::EmptyQuadrature) = []
