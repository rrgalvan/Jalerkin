import numpy as np
from numpy.core.multiarray import array as array

class Quadrature():

    def __init__(self,nodes: np.array, weights: np.array):
        
        assert len(nodes)==len(weights), "Different dimension for nodes and weights"
        
        self.nodes=nodes
        self.weights=weights
    
    def get_nodes(self):
        return self.nodes

    def get_weights(self):
        return self.weights
    
    def quad_f(self, f):
        return np.dot(self.weights, [f(x,y) for x,y in self.nodes])
        
    
    def quad(self, val: np.array):
        return np.dot(self.weights,val)
    
#Trapezoid quadrature rule on interval [-1, 1]
class TrapezoidQuadrature1D(Quadrature):
    def __init__(self):
        self.nodes=np.array([-1,1])
        self.weights=np.array([1,1])

class TrapezoidQuadrature2D(Quadrature):
    def __init__(self):
        self.nodes=np.array([[0,0],[1,0],[0,1]])
        self.weights=np.array([1/6,1/6,1/6])

# Gauss Legendre Implement
