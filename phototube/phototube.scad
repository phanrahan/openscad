use <threads/threads.scad>

/*
- phototube
	- eyepiece tube
        - 25mm outer diameter
        - 23.2 inner diameter
	- trinocular tube cap
	-   10mm high
	-   5mm knob, 34mm diameter (knurled)
	-   M28x1,4mm of thread
*/

$fa=2;

difference() {
    union() {
        cylinder(d=25, h=40);
        metric_thread (diameter=28, pitch=1, length=4);
        translate([0,0,4])
            cylinder(r=17, h=6);
    }
    translate([0,0,-1]) cylinder(d=23.2, h=42);
}
