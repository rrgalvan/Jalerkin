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
function FiniteElement(mesh::Mesh, ::Type{FE_Fam}, order; quad_rule=GaussianQuadrature(2*order)) where {Mesh <: AbstractMesh, FE_Fam <: FE_Family}
    FiniteElement{Mesh, FE_Fam, order}(mesh, quad_rule)
end

"""
Return the mesh of a Finite Element
"""
@inline get_mesh(fe::FiniteElement)  = fe.mesh

"""
Return the quadrature rule of a Finite Element
"""
@inline get_quad_rule(fe::FiniteElement)  = fe.quad_rule

"""
Return the polynomial order of a Finite Element
"""
@inline get_order(fe::FiniteElement{Mesh, FE_T, order}) where {Mesh, FE_T, order} = order
