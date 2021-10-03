module QuadTests

using Test
using Jalerkin

# Compute $\int_0^1 x^3 dx$ using Simpson's quad. rule
nodes = [0, 0.5, 1]
weights = [1/6, 2/3, 1/6]
qr = Quadrature{3, Float64}(nodes, weights)
@test quad(qr, x->x^3) ≈ 0.25

# Test trapezoid quad. rule
@test quad(TrapezoidQuad(), [0., 1.]) ≈ 0.5

end #module
