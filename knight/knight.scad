// Knight (drawing 280) as CSG of circles and rectangles. Units: mm.
// Origin: bottom of base on the centre line. Rectangles are centred squares, optionally rotated.
$fn=180;
// 2D profile; wrap in linear_extrude(h) for a solid
union() {  // KNIGHT
  difference() {  // body minus cuts
    union() {  // solid body
      translate([0.000,7.000]) square([75.000,14.000],center=true);  // R1 base 75x14
      translate([0.000,25.750]) square([75.000,23.500],center=true);  // R2 lower stem
      translate([0.000,42.500]) square([58.000,57.000],center=true);  // R3 neck core
      translate([-28.404,53.020]) rotate(75.763) square([34.562,10.000],center=true);  // R4 left fill strip (edge on line waistL-R11L centres)
      translate([28.404,53.020]) rotate(-75.763) square([34.562,10.000],center=true);  // R5 right fill strip
      translate([-29.000,71.000]) circle(r=11);  // C1 R11 left shoulder
      translate([29.000,71.000]) circle(r=11);  // C2 R11 right shoulder
      difference() {  // R41 chest, trimmed to the sector above its tangent points
        translate([0.000,63.319]) circle(r=41);  // C3 R41 chest
        translate([-80.208,-122.333]) rotate(-14.835) square([400.000,400.000],center=true);  // trim below R41->R11L ray
        translate([51.208,-130.014]) rotate(14.835) square([400.000,400.000],center=true);  // trim below R41->R11R ray
      }
      difference() {  // R63 back of head, trimmed to the sector between its tangent points
        translate([-13.028,101.621]) circle(r=63);  // C4 R63 back
        translate([-130.802,-60.024]) rotate(-36.077) square([400.000,400.000],center=true);  // trim beyond R63->R11R ray
        translate([-177.033,219.462]) rotate(-117.728) square([400.000,400.000],center=true);  // trim beyond R63->R35 ray
      }
      translate([0.000,126.406]) circle(r=35);  // C5 R35 crown
    }
    translate([-37.500,37.500]) circle(r=23.5);  // C6 waist cut L
    translate([37.500,37.500]) circle(r=23.5);  // C7 waist cut R
    difference() {  // R45 throat cut, lower half only
      translate([-48.820,134.118]) circle(r=45);  // C8 R45 throat
      translate([22.954,326.143]) rotate(172.186) square([400.000,400.000],center=true);  // keep only below the R45-centre->spike line
    }
  }
  difference() {  // muzzle and jaw
    union() {  // face polygon (two convex pieces)
      difference() {  // face piece A
        translate([-35.000,130.000]) square([70.000,100.000],center=true);  // bounding box
        translate([-17.000,357.000]) rotate(180.000) square([400.000,400.000],center=true);  // trim along Fb-Eb
        translate([171.878,86.028]) rotate(77.005) square([400.000,400.000],center=true);  // trim along Eb-Ø38 ctr
        translate([172.337,78.621]) rotate(83.520) square([400.000,400.000],center=true);  // trim along Ø38 ctr-jawR11 ctr
        translate([-85.088,-90.941]) rotate(-11.563) square([400.000,400.000],center=true);  // trim along jawR11 ctr-R8 ctr
        translate([-223.858,209.468]) rotate(-105.209) square([400.000,400.000],center=true);  // trim along R8 ctr-Fb
      }
      difference() {  // face piece B
        translate([-35.000,130.000]) square([70.000,100.000],center=true);  // bounding box
        translate([-208.171,249.530]) rotate(-117.558) square([400.000,400.000],center=true);  // trim along nose tip-Fb
        translate([147.995,52.532]) rotate(74.791) square([400.000,400.000],center=true);  // trim along Fb-R8 ctr
        translate([107.722,-24.383]) rotate(52.020) square([400.000,400.000],center=true);  // trim along R8 ctr-T8
        translate([-181.077,-52.645]) rotate(-37.980) square([400.000,400.000],center=true);  // trim along T8-nose tip
      }
    }
    translate([-26.386,101.192]) circle(r=11);  // C9 R11 jaw cut
  }
  translate([-45.000,105.000]) circle(r=8);  // C10 R8 nose
  translate([-23.000,131.000]) circle(r=19);  // C11 Ø38 jaw
  difference() {  // ear
    translate([-25.000,162.500]) square([30.000,25.000],center=true);  // R ear box
    translate([-229.765,131.062]) rotate(-78.189) square([400.000,400.000],center=true);  // trim front ear edge
    translate([115.324,306.968]) rotate(138.576) square([400.000,400.000],center=true);  // trim back ear edge
  }
}
