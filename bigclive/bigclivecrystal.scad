//Big Clive 21/Jan/2020 LED quartz
difference(){
union(){
difference(){
union(){
//six sub crystals
    rotate([45, 0, 0])
cylinder(h =80, d1 = 30,d2 = 20,$fn=6);
    rotate([45, 0, 0])
    translate([0,0,80])
cylinder(h =10, d1 = 20,d2 = 0,$fn=6);
    
    rotate([45, 0, 60])
cylinder(h =80, d1 = 30,d2 = 20,$fn=6);
    rotate([45, 0, 60])
    translate([0,0,80])
cylinder(h =10, d1 = 20,d2 = 0,$fn=6);
    
    rotate([45, 0, 120])
cylinder(h =80, d1 = 30,d2 = 20,$fn=6);
    rotate([45, 0, 120])
    translate([0,0,80])
cylinder(h =10, d1 = 20,d2 = 0,$fn=6);
  
    rotate([45, 0, 180])
cylinder(h =80, d1 = 30,d2 = 20,$fn=6);
    rotate([45, 0, 180])
    translate([0,0,80])
cylinder(h =10, d1 = 20,d2 = 0,$fn=6);

    rotate([45, 0, 240])
cylinder(h =80, d1 = 30,d2 = 20,$fn=6);
    rotate([45, 0, 240])
    translate([0,0,80])
cylinder(h =10, d1 = 20,d2 = 0,$fn=6);

    rotate([45, 0, 300])
cylinder(h =80, d1 = 30,d2 = 20,$fn=6);
    rotate([45, 0, 300])
    translate([0,0,80])
cylinder(h =10, d1 = 20,d2 = 0,$fn=6);
    
//main central crystal
    translate([0, 0, 0])
cylinder(h =100, d1 = 50,d2 = 20,$fn=6);
//main crystal tip    
       translate([0, 0, 100])
cylinder(h =10,d1=20,d2=0,$fn=6);
 
}
//remove central crystal core
    translate([0, 0, -1])
cylinder(h =101.1, d1 = 48,d2 = 18,$fn=6);
//remove centre crystal tip
       translate([0, 0, 100])
cylinder(h =9,d1=18,d2=0,$fn=6);

//six sub crystal core removal
    rotate([45, 0, 0])
    translate([0,0,0])
cylinder(h =80.1, d1 = 28,d2 = 18,$fn=6);
    rotate([45, 0, 0])
    translate([0,0,80])
cylinder(h =9, d1 = 18,d2 = 0,$fn=6);
 
    rotate([45, 0, 60])
    translate([0,0,0])
cylinder(h =80.1, d1 = 28,d2 = 18,$fn=6);
    rotate([45, 0, 60])
    translate([0,0,80])
cylinder(h =9, d1 = 18,d2 = 0,$fn=6);

    rotate([45, 0, 120])
    translate([0,0,0])
cylinder(h =80.1, d1 = 28,d2 = 18,$fn=6);
    rotate([45, 0, 120])
    translate([0,0,80])
cylinder(h =9, d1 = 18,d2 = 0,$fn=6);

    rotate([45, 0, 180])
    translate([0,0,0])
cylinder(h =80.1, d1 = 28,d2 = 18,$fn=6);
    rotate([45, 0, 180])
    translate([0,0,80])
cylinder(h =9, d1 = 18,d2 = 0,$fn=6);

    rotate([45, 0, 240])
    translate([0,0,0])
cylinder(h =80.1, d1 = 28,d2 = 18,$fn=6);
    rotate([45, 0, 240])
    translate([0,0,80])
cylinder(h =9, d1 = 18,d2 = 0,$fn=6);

    rotate([45, 0, 300])
    translate([0,0,0])
cylinder(h =80.1, d1 = 28,d2 = 18,$fn=6);
    rotate([45, 0, 300])
    translate([0,0,80])
cylinder(h =9, d1 = 18,d2 = 0,$fn=6);
    }
//Second solid additions

//Add base cone
translate([0,0,3])
cylinder(h =45, d1 = 100,d2 = 7,$fn=6);    

//led plinths
rotate([45, 0, 0])
translate([0,0,30])
cylinder(h =5.5, d1 = 20,d2 = 8,$fn=20);
    
rotate([45, 0, 60])
translate([0,0,30])
cylinder(h =5.5, d1 = 20,d2 = 8,$fn=20);
    
rotate([45, 0, 120])
translate([0,0,30])
cylinder(h =5.5, d1 = 20,d2 = 8,$fn=20);
    
rotate([45, 0, 180])
translate([0,0,30])
cylinder(h =5.5, d1 = 20,d2 = 8,$fn=20);
    
rotate([45, 0, 240])
translate([0,0,30])
cylinder(h =5.5, d1 = 20,d2 = 8,$fn=20);

rotate([45, 0, 300])
translate([0,0,30])
cylinder(h =5.5, d1 = 20,d2 = 8,$fn=20);

//cable entry
translate([0,-35,10])
rotate([45, 0, 0])
sphere (d=10,$fn=20);
   
}
//Second removals
//Inner base area
translate([0,0,2])
cylinder(h =45, d1 = 100,d2 = 6,$fn=6); 

//base removal cube
translate([-50,-50,-47])
cube ([100,100,50]);

//LED hole removal
    rotate([45, 0, 0])
    translate([0,0,26])
cylinder(h =10,d1=5,d2=5,$fn=20);

    rotate([45, 0, 60])
    translate([0,0,26])
cylinder(h =10,d1=5,d2=5,$fn=20);

    rotate([45, 0, 120])
    translate([0,0,26])
cylinder(h =10,d1=5,d2=5,$fn=20);

    rotate([45, 0, 180])
    translate([0,0,26])
cylinder(h =10,d1=5,d2=5,$fn=20);

    rotate([45, 0, 240])
    translate([0,0,26])
cylinder(h =10,d1=5,d2=5,$fn=20);

    rotate([45, 0, 300])
    translate([0,0,26])
cylinder(h =10,d1=5,d2=5,$fn=20);

//main pillar LED hole
    translate([0,0,40])
cylinder(h =10,d1=5,d2=5,$fn=20);

//cable entry
translate([0,-35,10])
rotate([45,0,0])
cylinder(h =20, d1 = 4,d2 = 4,$fn=20);
}
