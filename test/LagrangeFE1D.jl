module MeshTests

using Test
using Jalerkin


ncells = 2
mesh = Mesh1D(0, 1, ncells)
fe = FiniteElement(mesh, Lagrange, 1)

# Basis functions
phi = get_phi(fe)
@test phi[1] ≈ [0.7886751345948129, 0.21132486540518708]
@test phi[2] ≈ [0.21132486540518708, 0.7886751345948129]

# Derivative of basis functions
dphi = get_dphi(fe)
@test dphi[1] == [-0.5, -0.5]
@test dphi[2] == [+0.5, +0.5]

# Jacobian x quad_weights (cells 1 & 2)
@test get_JxW(fe, 1) == [0.25; 0.25]
@test get_JxW(fe, 2) == [0.25; 0.25]

end # module
