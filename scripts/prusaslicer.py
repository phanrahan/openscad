import subprocess

prusa='/Applications/PrusaSlicer.app/Contents/MacOS/PrusaSlicer'

def runcmd(filename, cmd):
    cmd = [prusa] + cmd + [filename]
    print(cmd)
    subprocess.run(cmd)

def run(filename, gcode, config):
    cmd = [prusa, "--center", "125,105", "--export-gcode", "--loglevel", "0"] + \
          ["--load", config] + \
          ["--output", gcode] + \
          [filename] 
    print(cmd)
    subprocess.run(cmd)


