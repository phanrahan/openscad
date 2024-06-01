/* This example uses TrinaryLogic's gear code for demonstrating crossed
 * helical gears. That is, two helical gears transmitting torque between
 * non-intesecting shafts that are crossing at an arbitrary angle.
 *
 * Reference:
 *   https://www.geartechnology.com/issues/0986x/back-to-basics.pdf
 *   https://nptel.ac.in/courses/116102012/57
 *
 * NOTE: Initially I had been having little luck making crossed helical
 * gears using GregFrost's library. It turns out that the key difference
 * is that TrinaryLogic's library defines the twist parameter as a helical
 * angle, whereas in GregFrost's library the twist parameter is something
 * else.
 */

/* Public Domain Involute Parameterized Gears: Powered Up
 *   by TrinaryLogic (https://www.thingiverse.com/thing:2854963)
 */
use <publicDomainGearV1.3_trinarylogic.scad>

/* GregFrost's library uses "outside_circular_pitch", which is related to
 * "mm_per_tooth" as used in trinarylogic's library.
 */
function mm_per_tooth(outside_circular_pitch) = outside_circular_pitch / 180 * PI;

$fn = 30;

number_of_teeth        = 30;
outside_circular_pitch = 100;
twist                  = 15;
thickness              = 3;

module crossed_helical_gears(
    mm_per_tooth           = 3, // this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
    number_of_teeth_1      = 30,  //total number of teeth around the entire perimeter of gear 1
    number_of_teeth_2      = 15,  //total number of teeth around the entire perimeter of gear 2
    angle_between_shafts   = 90,
    pressure_angle         = 25,
    clearance              = 0.0,
    thickness              = 5,
    hole_diameter          = 3
) {
    function outside_pitch_radius(teeth) = teeth * mm_per_tooth / (2 * PI);
    
    twist = angle_between_shafts / 2;
    
    color("green")
    translate([0,-outside_pitch_radius(number_of_teeth_1)])
    rotate([0,0,-360/number_of_teeth_1*$t])
    gear (number_of_teeth=number_of_teeth_1,
                mm_per_tooth=mm_per_tooth,
                pressure_angle=pressure_angle,
                clearance = clearance,
                thickness = thickness,
                hole_diameter=hole_diameter,
                twist=twist);
    
    color("red")
    rotate([0,angle_between_shafts,0])
    translate([0,outside_pitch_radius(number_of_teeth_2)])
    rotate([0,0,360/number_of_teeth_2*$t])
    gear (number_of_teeth=number_of_teeth_2,
                mm_per_tooth=mm_per_tooth,
                pressure_angle=pressure_angle,
                clearance = clearance,
                thickness = thickness,
                hole_diameter=hole_diameter,
                twist=twist);
}

crossed_helical_gears(angle_between_shafts = 45);