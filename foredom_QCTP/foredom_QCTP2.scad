include <BOSL2/std.scad>

$fn = 60;

D = 25;
H = 75;
THICK=4;
SLOT = 1;

bracket = union(circle(d=D+2*THICK), right(D/2+THICK-2, p=square([12,12], anchor=LEFT)));

//i = round_corners(bracket, r=1,$fn=12);
//echo(bracket);

o = offset(bracket, r=2);
i = offset(o, r=-2);

linear_extrude(H)
    difference() {
        polygon(i);
        circle(d=D);
        square([2*D,SLOT], anchor=LEFT);
    }
