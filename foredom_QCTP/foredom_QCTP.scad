include <BOSL2/std.scad>

$fn = 60;
IN = 25.4;

D = IN;
L = 75;
THICK=6;
SLOT = 0.8;

bracket = union(circle(d=D+2*THICK), right(D/2+THICK-2, p=square([10,13], anchor=LEFT)));

//i = round_corners(bracket, r=1,$fn=12);
//echo(bracket);

o = offset(bracket, r=2);
i = offset(o, r=-2);

//intersection() {
difference() {
    linear_extrude(L)
        polygon(i);
     cylinder(h=L, d=D);
     up(L-1.00*IN) 
         union() {
             up(0.125*IN) cylinder(h=IN, d=1.25*IN);
             cylinder(h= 0.125*IN, d1=1.00*IN, d2=1.25*IN);
         }
     cube([2*D,SLOT,L], anchor=LEFT+BOTTOM);
}
/*
cube([100,100,100], align=BOTTOM+FRONT);
}
*/
