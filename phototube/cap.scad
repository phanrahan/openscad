use <threads/threads.scad>

/*
trinocular tube cap
	-   5mm x 34mm diameter knob (knurled)
	-   5mm M28x1 thread
*/

$fa=2;

union() {
    metric_thread (diameter=28, pitch=1, length=5);
    translate([0,0,4])
            cylinder(d=34, h=5);
}
