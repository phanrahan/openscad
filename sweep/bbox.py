import numpy
from stl import mesh

# Using an existing stl file:
sweep = mesh.Mesh.from_file('sweep.stl')

print(sweep.min_, sweep.max_)
