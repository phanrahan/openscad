import subprocess

openscad='/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD'

def string(param):
    s = str(param)
    if type(param) == str: 
        s = f"\"{s}\""
    return s

def defines(params):
    return [f"{key}={string(val)}" for key, val in params.items()]

def flatten(l):
    return [item for inner in l for item in inner]

def zipD(params):
    return flatten([["-D", param] for param in params]) 

def run(scad, stl, **kwargs):
    Ds = zipD(defines(kwargs))
    subprocess.run([openscad, scad] + Ds + ["-o", stl])



