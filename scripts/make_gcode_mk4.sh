#!/bin/bash
prusa='/Applications/PrusaSlicer.app/Contents/MacOS/PrusaSlicer'

filament=pla
printer=mk4

for stl in *.stl
do
    file=`basename $stl .stl`
    echo converting $file.stl to  $file.$filament.$printer.gcode
    $prusa --center 125,105 --export-gcode --loglevel 0 --load config.$filament.$printer.ini  --output $file.$filament.$printer.gcode $file.stl
done


