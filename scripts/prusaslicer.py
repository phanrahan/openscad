import subprocess

prusa='/Applications/Original Prusa Drivers/PrusaSlicer.app/Contents/MacOS/PrusaSlicer'

def runcmd(cmd,filenames):
    if not isinstance(filenames, list):
        filenames = [filenames]
    cmd = [prusa] + cmd + filenames
    print(cmd)
    subprocess.run(cmd)

def run(filename, gcode, config):
    cmd = [prusa, "--center", "125,105", "--export-gcode", "--loglevel", "0"] + \
          ["--load", config] + \
          ["--output", gcode] + \
          [filename] 
    print(cmd)
    subprocess.run(cmd)


