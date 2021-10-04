module QuadTests

using Test
using Jalerkin

# Compute $\int_0^1 x^3 dx$ using Trapezoid quad. rule
nodes = [0, 1]
weights = [0.5, 0.5]
qr = Quadrature{2}(nodes, weights)
@test quad(qr, x->x) ≈ 0.5  # Exact for P1
@test !(quad(qr, x->x^2) ≈ 1/3)  # Not exact for P2

# Compute $\int_0^1 x^3 dx$ using Simpson's quad. rule
nodes = [0, 0.5, 1]
weights = [1/6, 2/3, 1/6]
qr = Quadrature{3}(nodes, weights)
@test quad(qr, x->x^3) ≈ 0.25

# Test Gaussian quad. rule on [-1,1]
@test quad(GaussianQuadrature(4), x->x^6) ≈ 2/7

end #module
