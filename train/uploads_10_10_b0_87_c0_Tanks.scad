


//  Size in feet
diam = 30;
height = 30;
dome = 4;				//  Added dome on top is this high
scale = 160;			//  N-scale = 160
topvalve_diam = 3;
topvalve_hi = .5;
welded = true;		//  To show welding seams or not

//  calculate in scale mm
Rad = diam*12*25.4/(scale*2);
Tall = height*12*25.4/scale;
AddTo = dome*12*25.4/scale;
Vrad = topvalve_diam*6*25.4/scale;
Vhi = topvalve_hi*12*25.4/scale;
Angle = atan(AddTo/Rad);
Srad = Rad/sin(Angle);
Steps = floor(height/4);
StepUp = Tall/Steps;
SideHatch = 4*25.4*12/scale;

Circ = 3.14159*2*Rad;
Pangle = (96*25.4/scale*360)/Circ;
Psteps = 180/Pangle;

$fn= 120;

echo("Dimensions",Rad, Tall,Angle,Srad,Steps,Circ,Pangle,Psteps);

cylinder(r=Rad, h=Tall);
intersection()  {
	translate([0, 0, Tall])cylinder(r=Rad, h=AddTo*4);
	translate([0, 0, -Srad+Tall+AddTo/2])sphere(r=Srad);
}

	translate([0, 0, Tall-0.4]) cylinder(r=Rad+0.3, h=.4);
if(welded)
	for(n=[0 : Steps-1])  {
		translate([0, 0, n*StepUp]) cylinder(r=Rad+0.3, h=.4);
		translate([0,0, n*StepUp+StepUp/2])
			rotate([0, 0, Pangle*n/2])for(j = [0:Psteps])  {
			 rotate([0, 0, j*Pangle])cube([0.6, Rad*2+0.4, StepUp], center=true);
		}

	} 

translate([0, 0, Tall+AddTo-Vhi])cylinder(r=Vrad, h=Vhi*2);
if(SideHatch > 0)
	translate([0, -Rad-0.5, .2*Tall + SideHatch/2+Vrad]) rotate([-90, 0, 0]) cylinder(r=SideHatch, h =  4);
translate([0, -Rad-1,  Vrad+2]) rotate([-90, 0, 0])cylinder(r = Vrad, h=4);