include <BOSL2/std.scad>

$fn = 60;
IN = 25.4;

BUILD = "6mm";

D = IN;
L = 75;
THICK=6;
SLOT = 0.8;

bracket = union(circle(d=D+2*THICK), right(D/2+THICK-2, p=square([12,13], anchor=LEFT)));

//i = round_corners(bracket, r=1,$fn=12);
//echo(bracket);

o = offset(bracket, r=2);
i = offset(o, r=-2);

module qctp() {
    difference() {
        linear_extrude(L)
            polygon(i);
        cube([2*D,SLOT,L], anchor=LEFT+BOTTOM);
    }
}

module handpiece_3mm() {
    cylinder(h=L, d=D);
}

module handpiece_6mm() {
    union() {
        cylinder(h=L, d=D);
        up(L-0.625*IN) {
            up(0.125*IN) cylinder(h=IN, d=1.25*IN);
            cylinder(h= 0.125*IN, d1=1.00*IN, d2=1.25*IN);
        }
    }
}

difference() {
     qctp();
     if( BUILD=="3mm")
         handpiece_3mm();
     else
         handpiece_6mm();
}
/*
intersection() {
   cube([100,100,100], align=BOTTOM+FRONT);
}
*/
