include <BOSL2/std.scad>
include <BOSL2/gears.scad>

teeth = 24;


module axle(m=1, hole=false, tolerance=0.05) {
    module 2d_axle() {
        intersection() {
            circle(d=4.8, $fn=36);
            union() {
                rect([1.8, 4.8]);
                rect([4.8, 1.8]);
            }
        }
    }
    linear_extrude(m*8-0.15)
        if (hole) offset(r=tolerance) 2d_axle();
        else offset(r=-tolerance) 2d_axle();
}


difference() {
    spur_gear(mod=1, teeth=teeth, thickness=4, shaft_diam=0);
    axle();
}
