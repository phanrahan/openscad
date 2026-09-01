include <BOSL2/std.scad>

$fn=120;

IN = 25.4;

OD = 1.5*IN;
ID = (1+1/32)*IN;
HOLE = (3/8+1/16)*IN;

difference() {

}

module chamfer_cylinder(d, h, chamfer) {
  
}

difference() {
   union() {
       difference() {
           cylinder(d=ID, h=1.25*IN);
           up(1.25*IN) chamfer_cylinder_mask(d=ID, chamfer=2);
       }
       cylinder(d=OD, 0.25*IN);
   }
   cylinder(d=HOLE, h=2.5*IN);
}


