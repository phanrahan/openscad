shaft = [3.0, 4.0, 5.0, 6.0, 8.0];
fudge = [0.2, 0.4, 0.6];

spacing = 25;
length = len(fudge)*spacing;
width = len(shaft)*spacing;
thickness = 10;

module holes(shaft_d) {
    echo(shaft_d);
    for( i = [0 : len(fudge)-1] )
       translate([spacing/2+i*spacing, 0, 0]) 
           circle(d=shaft_d+fudge[i]);
}

linear_extrude(thickness)
    difference() {
        square([length, width]);
        for( i = [0 : len(shaft)-1] ) {
            translate([0, spacing/2+i*spacing, 0])
                holes(shaft[i]);
        }
    }
