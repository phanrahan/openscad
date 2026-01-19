import openscad

scad = "ring.scad"

for teeth in [60, 56]:
    openscad.run(scad, f"ring{teeth}.stl", teeth=teeth)

