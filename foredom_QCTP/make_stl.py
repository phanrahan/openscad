import openscad

scad = "foredom.scad"

for handpiece in ["3mm", "6mm"]:
    openscad.run(scad, f"handpiece_{handpiece}.stl", BUILD=handpiece)
