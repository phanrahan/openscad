
//#################################
// Based on interlocking 18650 battery holder
// by digitalkiwi thingiverse thing 2519293
//Licensed Creative Commons with attribution

// Rewritten by delboy711 on 27/07/18 to make it easier to join strips together
// and to allow the cells to pushed out of the negative holder for maintenance purposes.
//Also option for slots for cable ties to retain busbar

cells_x = 2;    // Number of cells in X dimension
cells_y = 2;    // Number of cells in Y dimension
negative = 0;   // If desired allow cell to be pushed all the way through
                // the negative holder for ease of maintenance
cable_tie = 1;  //Optional slot to thread cable tie to retain busbar

diameter = 18.8; // Diameter of 18650 cell
height = 6;      // Height of holder
tab = 1.4;       // Tab height
tolerance = 0.5;    // tolerance to help fit

// Make grid of cells
for ( y= [1:1:cells_y]) for ( x= [ 1:1:cells_x]) translate ([x*22,y*22,0]) cell();
    

//Fill gaps between cells
//gap= cable_tie==1 ? 20 : 22;
for ( x= [1:1:cells_x]) for ( y= [1:1:cells_y-1]) {    
    translate([22*x- (cable_tie ==1 ? 7: 12),22*y+10,0])cube([cable_tie ==1 ? 14 : 22,2,height]);
 
}

for ( x= [1:1:cells_x-1]) for ( y= [1:1:cells_y]) {    
    
    translate([22*x+12,22*y-(cable_tie ==1 ? 7: 10),0])rotate([0,0,90]) cube([cable_tie ==1 ? 14: 22,2,height]);
}


//Add Male connectors
for ( x= [1:1:cells_x]) translate([22*x,22*cells_y+11.4,0]) trapezoid(13);
for ( y= [1:1:cells_y]) translate([22*cells_x+11.4,22*y,0]) rotate([0,0,-90]) trapezoid(13);
    
//Add Female connector
for ( x= [1:1:cells_x]) {
    difference() {
        translate([22*x,11,height/2])cube([20,2,height],center=true);
        translate([22*x,10.8,0]) rotate([0,0,0]) trapezoid(13+tolerance);
    }
}
for ( y= [1:1:cells_y]) {
    difference() {
        rotate([0,0,90]) translate([22*y,-11,height/2])cube([20,2,height],center=true);
        rotate([0,0,90]) translate([22*y,-10.8,0]) rotate([0,0,180]) trapezoid(13+tolerance);
    }
}   




module trapezoid(length) {
     hull() { 
        translate([-length/2, 0, 0]) rotate([0,0,30]) cylinder (r = 2, h=height,  $fn=3); 
        translate([length/2, 0, 0]) rotate([0,0,30]) cylinder (r = 2, h=height,  $fn=3);
     }
    
}




// Module to create a single cell
module cell() {
    difference() {
        union () {
            translate([0,0,height/2])cube([20,20,height],center = true);
            
            // Optional tabs on top to retain cell
            // May be omitted on negative terminal to facilitate cell removal.
            if (!negative) for (rotation =[45:90:325]) rotate([0,0,rotation])  
                translate([0,9,0]) hull(){     
                translate([1,0,height]) cylinder(r=2, h=tab, $fn=16);
                translate([1,1,height]) cylinder(r=2, h=tab, $fn=16);
                translate([0,1,height]) cylinder(r=2, h=tab, $fn=16);
                translate([0,0,height]) cylinder(r=2, h=tab, $fn=16);
            } 
        
    }
        rotate([0,0,-0.1]) cylinder(r=diameter/2, h= height+ 0.2, $fn=64);    // Hole for cell
    
}

}
