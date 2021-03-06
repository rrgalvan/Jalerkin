module QuadTests

using Test
using Jalerkin

qr = TrapezoidQuadrature()
# Access to nodes and weights
@test(get_nodes(qr) == [-1,1])
@test(get_weights(qr) == [1,1])
# Compute $\int_{-1}^1 x dx$ using Trapezoidal quad. rule
@test quad(qr, x->x) ≈ 0  # Exact for P1
# Compute $\int_{-1}^1 x^2 dx$ using Trapezoidal quad. rule
@test !(quad(qr, x->x^2) ≈ 2/3)  # Not exact for P2

# Compute $\int_0^1 x^3 dx$ using Simpson's quad. rule
nodes = [0, 0.5, 1]
weights = [1/6, 2/3, 1/6]
qr = Quadrature{3}(nodes, weights)
@test quad(qr, x->x^3) ≈ 0.25

# Test Gaussian quad. rule on [-1,1]
@test quad(GaussianQuadrature(4), x->x^6) ≈ 2/7

end #module
