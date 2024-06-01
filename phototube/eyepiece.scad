/*
- eyepiece tube
        - 24mm inner diameter
        - 26mm outer diameter
*/

$fa=2;

difference() {
    cylinder(d=28, h=10);
    translate([0,0,-1]) cylinder(d=23.6, h=12);
}
