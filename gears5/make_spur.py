import openscad

scad = "spur.scad"

for teeth in [8, 16, 24, 40]:
    openscad.run(scad, f"spur{teeth}.stl", teeth=teeth)

