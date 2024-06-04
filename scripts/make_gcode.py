import glob
import prusaslicer

filament=pla
printer=mk4

for s in glob.glob("*.stl"):
    base, suffix = files.split(".")
    stl = base + ".stl"
    gcode = ".".join([base, filament, model])
    config = ".".join(["config", filament, model, "ini"])
    prusaslicer.run(stl, gcode, config)


