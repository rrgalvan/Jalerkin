import numpy as np

class Quadrature:
    """
    Quadrature formula
    """
    def __init__(self, nodes, wheights):
        self.nodes = nodes
        self.wheights = wheights

    def apply(self, f):
        """
        Approximate integral of a function using this quad. formula
        """
        return np.dot(self.wheights, f(self.nodes)) 
