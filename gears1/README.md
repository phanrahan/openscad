From https://www.thingiverse.com/thing:3575

This OpenSCAD script provides modules for both Spur and Bevel Gears.
It has some major enhancements over my original gear script
http://www.thingiverse.com/thing:3534. It uses some of the spur
gear nomenclature code from TheOtherRob http://github.com/TheOtherRob/MCAD
with my own code for generating the involute teeth. The bevel gear
is also my own work. Thanks also to elmom for some enhancements to
my original gear script http://www.thingiverse.com/thing:3547.

Enhancements include the Bevel gear module, backlash settings,
parameterised number of facets for the involute curve and whole of
tooth generation to avoid some of the issues the original script
had when mirroring a half tooth.

The STLs provided are not intended for direct use, but instead show
examples of what can be done with the parametric script.

Parametric Involute Spur Gears take the following parameters:

number_of_teeth 
circular_pitch or diametral_pitch: controls the
size of the teeth (and hence the size of the gear).
pressure_angle: controls the shape of the teeth.
clearance: The gap between the
root between teeth and the teeth point on a meshing gear.
gear_thickness: the thickness of the gear plate.
rim_thickness: the thickness of the gear at the rim (including the teeth).
rim_width: radial distance from the root of the teeth to the inside of the rim.
hub_thickness: the thickness of the section around the bore.
hub_diameter 
bore_diameter: size of the hole in the middle 
circles: the number of circular holes to cut in the gear plate.
backlash: the space between this the back of this gears teeth and the front
of its meshing gear\\'s teeth when the gear is correctly spaced
from it.
twist: for making helical gears.
involute_facets: the number of facets in one side of the involute tooth shape.
If this is omitted it will be 1/4 of $fn. If $fn is not set, it will be 5.

Parametric Involute Profile Bevel (Conical) Gears take the following
parameters: 
number_of_teeth 
cone_distance: The distance from the pitch apex to the outside pitch diameter.
face_width: The length of the teeth.
outside_circular_pitch: The circular pitch at the outside pitch diameter.
pressure_angle: Defines the shape of the teeth.
clearance: Gap between the tip of the teeth on one gear and
    the root of the teeth on another meshing gear.
bore_diameter: The size of the hole in the middle.
gear_thickness: The thickness of the gear for bevel_gear_back_cone finish (see below).
backlash: Makes the tooth width smaller to make a gap between teeth of correctly spaced gears to allow for manufacturing tolerances.
involute_facets: As for spur gears.
finish: Specify either bevel_gear_flat(0) or
bevel_gear_back_cone(1).
If you don't specify this parameter you
will get a flat gear for pitch angles less than 45 degrees and a
back cone gear for pitch angles greater than 45 degrees.

The example shows both with the small gear being the flat one.

Update: v5.0 Implements backlash for bevel gears (This was not
working in v4.0).

Instructions To make a pair of spur gears mesh, they must have the
same circular pitch and pressure angle. Look in the console window
and you will see the pitch radius of each gear produced. The axes
of two gears must be separated by the sum of their pitch radii to
mesh correctly. Use the backlash option to allow for the gears to
work with printing inaccuracies.

Bevel gears are more complicated. Meshing bevel gears have the same
cone distance, circular pitch and pressure angle. The cone distance,
circular pitch and number of teeth will define the pitch angle. The
example provided shows how to calculate the parameters for two gears
if you have a desired axis angle (the sum of the pitch angles for
the two bevel gears).
