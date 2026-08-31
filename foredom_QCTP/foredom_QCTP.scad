$fn = 60;

    difference() {
        union() {
            cylinder(d=25+8, h=75);
            translate([(25+8+6)/2,0,75/2])
                cube([15,12,75],center=true);
         }
        cylinder(d=25, h=75);
        translate([(25+8)/2,0,75/2]) 
            cube([24,2,75],center=true);
    }
