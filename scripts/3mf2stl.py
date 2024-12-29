import glob
import prusaslicer

for file in glob.glob("*.3mf"):
    prusaslicer.runcmd(file, ["--export-stl"])


