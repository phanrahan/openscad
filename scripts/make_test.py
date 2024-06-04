import openscad

scad = "test.scad"

for x, s in [(2, "yes")]:
    openscad.run(scad, "test.stl", X=x, S=s);

