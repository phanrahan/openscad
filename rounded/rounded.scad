include <BOSL2/std.scad>

$fn=60;

cross = union(rect([50,25]), rect([25,50]));
rounded_cross = round_corners(cross, r=5);
//region(cross);
//region(rounded_cross);

// round convex corners 
region(union(cross, rounded_cross));

// round convave corners - fillet
//region(intersection(cross, rounded_cross));
