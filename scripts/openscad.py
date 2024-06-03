import subprocess

openscad='/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD'

def defines(params):
    return [f"{key}={val}" for key, val in params.items()]

def flatten(l):
    return [item for inner in l for item in inner]

def zipD(params):
    return flatten([["-D", param] for param in params]) 

def run(scad, params, stl):
    Ds = zipD(defines(params))
    subprocess.run([openscad, scad] + Ds + ["-o", stl])



