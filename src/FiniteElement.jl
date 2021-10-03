abstract type AbstractAffineMap <: JalerkinType end

# """
# Data type for 1-d affine mappings, $F:[0,1] -> [x0,x1]$,
# defined as: $F(t)=a\cdot t + b$, $a, b \in \mathbb R$.
# """
struct AffineMap1D{T <: Real} <: AbstractAffineMap
    "Multiplicative coefficient"
    a :: T
    "Translation coefficient"
    b :: T
    "Determinant of the jacobian (= a in the 1D case)"
    det_jacobian :: T
end

#--- Finite Element

abstract type Abstract_FE_Type <: JalerkinType end
"""
Lagrange family of finite elements
"""
struct Lagrange <: Abstract_FE_Type end;

"""
Finite element (of a given type) on a mesh
"""
struct FiniteElement{Mesh <: AbstractMesh, FE_Type <: Abstract_FE_Type, order}
    mesh :: Mesh
    quad_rule :: AbstractQuadrature
end

"""
Constructor of a FiniteElement from a mesh, a FE family and an polinomial order"
"""
function FiniteElement(mesh::Mesh, ::Type{FE_T}, order) where {
    Mesh <: AbstractMesh, FE_T <: Abstract_FE_Type}
    FiniteElement{Mesh, FE_T, order}(mesh, EmptyQuadrature())
end

"""
Return order of a Lagrenge Finite Element
"""
get_order(fe::FiniteElement{Mesh, FE_T, order}) where {Mesh, FE_T, order} = order

"""
Assign a quadrature rule to be used to assembling linear system
"""
function attach_quad_rule(fe::FiniteElement, qr::AbstractQuadrature)
    fe.quad_rule = qr
end
