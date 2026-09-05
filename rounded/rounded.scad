include <BOSL2/std.scad>

cross = union(rect([50,25]), rect([25,50]));
rounded_cross = round_corners(cross, r=5, $fn=60);
//region(cross);
//region(rounded_cross);

// fillet concave corners 
region(union(cross, rounded_cross));

// round convex corners
//region(intersection(cross, rounded_cross));
