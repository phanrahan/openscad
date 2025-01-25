import openscad

scad = "JarAndCap.scad"

for d, h in [(30, 8), (50, 8)]:
    openscad.run(scad, f"cap_{d}.stl", diameter=d, height=h, JAR=0)
    openscad.run(scad, f"jar_{d}.stl", diameter=d, height=h, JAR=1)

