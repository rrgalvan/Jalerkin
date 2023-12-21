import numpy as np


class Mesh1D():
    
    def __init__(self, a: float, b: float, ncells: int):
        self.ncells=ncells

        self.vertices=np.array([[i,i+1] for i in range(ncells)])
        self.coords=np.linspace(a,b,ncells+1)
    
    def get_cell_to_vertex(self):
        # Return vertices 
        return self.vertices
    
    def get_coords(self):
        return self.coords
     
    def num_cells(self):
        return self.ncells
    
    def num_vertices(self):
        return len(self.vertices)
    
class Mesh2D():

    def __init__(self, x: tuple, y: tuple, ncellsx: int, ncellsy: int):
        
        coords=np.zeros(((ncellsx+1)*(ncellsy+1),2))
        k=0
        for j in np.linspace(y[0],y[1], ncellsy+1)[::-1]:
            for i in np.linspace(x[0],x[1], ncellsx+1):
                coords[k]=np.array([i,j])
                k+=1        
        self.coords= coords
        

        vertices=[]
        for j in range(ncellsy):
            for i in range(ncellsx):
                index_0=i+j*(ncellsx+1)
                vertices.append([index_0, index_0+1+ncellsx,index_0+2+ncellsx])
                vertices.append([index_0,index_0+1,index_0+2+ncellsx])
        
        self.vertices=vertices

    def get_cell_to_vertex(self):
        # Return vertices 
        return self.vertices

    def get_coords(self):
        return self.coords
    
    def num_cells(self):
        return self.ncells
    
    def num_vertices(self):
        return len(self.vertices)
