module QuadTests

using Test
using Jalerkin

@test quad([0., 1.], TrapezoidQuad()) ≈ 0.5

end #module
