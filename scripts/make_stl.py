import openscad

scad = "JarAndCap.scad"

for diameter, height in [(30, 8)]:
    params = {"diameter": diameter, "height": height, "JAR": 0}
    openscad.run(scad, params, f"cap_{diameter}.stl")
    params = {"diameter": diameter, "height": height, "JAR": 1}
    openscad.run(scad, params, f"jar_{diameter}.stl")

