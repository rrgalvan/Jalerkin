abstract type AbstractAffineMap <: JalerkinType end

# """
# Data type for 1-d affine mappings, $F:[0,1] -> [x0,x1]$,
# defined as: $F(t)=a\cdot t + b$, $a, b \in \mathbb R$.
# """
struct AffineMap1D <: AbstractAffineMap
    "Multiplicative coefficient"
    a :: fp_precision()
    "Translation coefficient"
    b :: fp_precision()
    "Determinant of the jacobian (=a, in 1D)"
    det_jacobian :: fp_precision()
end

#--- Finite Element

abstract type FE_Family <: JalerkinType end
abstract type Abstract_FE <: JalerkinType end

"""
Lagrange family of finite elements
"""
struct Lagrange <: FE_Family end;

"""
Finite element (of a given type) on a mesh
"""
struct FiniteElement{Mesh <: AbstractMesh, FE_Fam <: FE_Family, order}
    mesh :: Mesh
    quad_rule :: AbstractQuadrature
end

"""
Constructor of a FiniteElement from a mesh, a FE family and a polinomial order"

A Gauss Quadrature rule is chosen such that the mass matrix is computed exactly
"""
function FiniteElement(mesh::Mesh, ::Type{FE_Fam}, order;
    quad_rule=GaussianQuadrature(2*order)) where {
        Mesh <: AbstractMesh,
        FE_Fam <: FE_Family }

    FiniteElement{Mesh, FE_Fam, order}(mesh, quad_rule)
end

"""
Return the mesh of a Finite Element
"""
@inline get_mesh(fe::FiniteElement) = fe.mesh

"""
Return the quadrature rule of a Finite Element
"""
@inline get_quad_rule(fe::FiniteElement) = fe.quad_rule

"""
Return the polynomial order of a Finite Element
"""
@inline get_order(fe::FiniteElement{Mesh, FE_T, order}) where {
    Mesh, FE_T, order} = order

"""
Return the nuber of local degrees of freedom of a Finite Element
"""

@inline function num_local_dofs(fe::FiniteElement)
    @abstractmethod
end

"""
Return the nuber of local degrees of freedom of a P1-Lagrenge
Finite Element on a 0d mesh
"""
@inline num_local_dofs(fe::FiniteElement{Mesh, Lagrange, 1}) where {Mesh} = 2

"""
Return P1-Lagrange shape functions evaluated at the quadrature points.
"""
function get_phi(fe::FiniteElement{Mesh, Lagrange, 1} where Mesh)
    # Lagrange basis polynomials on {x0,x1}={-1,1}
    phi1 = x -> -0.5*(x-1)
    phi2 = x -> +0.5*(x+1)
    # Evaluation on quadrature nodes
    qnodes = get_nodes(get_quad_rule(fe))
    [map(phi1, qnodes), map(phi2, qnodes)]
end

"""
return P2-Lagrange shape functions evaluated at the quadrature points.
"""
function get_phi(fe::FiniteElement{Mesh, Lagrange, 2}) where Mesh
    # Lagrange basis polynomials on {x0,x1,x2}={-1,0,1}
    phi1 = x -> -0.5*(x-0)*(x-1)
    phi2 = x -> -(x+1)*(x-1)
    phi3 = x -> +0.5*(x+1)*(x-0)
    # Evaluation on quadrature nodes
    qnodes = get_nodes(get_quad_rule(fe))
    [map(phi1, qnodes), map(phi2, qnodes), map(phi3, qnodes)]
end

"""
Element Jacobian of one element * quadrature weight at each integration point.
"""
function get_JxW(fe::FiniteElement{Mesh, Lagrange, order}, element_index) where {Mesh, order}
    mesh = get_mesh(fe)
    coord = get_coords(mesh)
    cell2vertex = get_cell_to_vertex(mesh)
    x1 = coord[cell2vertex[element_index]][1][1]
    x2 = coord[cell2vertex[element_index]][2][1]
    J_affine_map = 0.5*(x2-x1)
    q_weights = get_weights(get_quad_rule(fe))
    return J_affine_map*q_weights
end
