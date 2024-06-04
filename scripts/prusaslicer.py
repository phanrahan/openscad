import subprocess

prusa='/Applications/PrusaSlicer.app/Contents/MacOS/PrusaSlicer'

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

def run(stl, gcode, config):
    #Ds = zipD(defines(kwargs))
    subprocess.run( [prusa,
        "--center 125,105 --export-gcode --loglevel 0"]+ 
        ["--load", config],
        [gcode, stl] )


