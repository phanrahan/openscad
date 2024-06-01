/* Quadratic Bezier Curve and Cubic Bezier Curve demonstration
Given three points in a plane a quadratic bezier curve can be created according to the formula 

Quadratic Bezier
B(t)=(1-t)(1-t)p0+2(1-t)(t)p1+(t)(t)p2

Cubic Bezier
B(t)=(1-t)(1-t)(1-t)p0+3(1-t)(1-t)(t)p1+3(1-t)(t)(t)p2+(t)(t)(t)p3

see: https://en.wikipedia.org/wiki/B%C3%A9zier_curve
and: https://www.joecridge.me/content/pdf/bezier-arcs.pdf

A good explanation on Bezier Curve van be found here:
https://www.youtube.com/watch?v=Qu-QK3uoMdY
*/

//radius determines the size of the base of the vase
radius = 30;
//three points (p0,p1,p2) needed to create the quadratic bezier curve
//four points (p0,p1,p2,p3) needed to create the cubic bezier curve
p0 = [radius,0];
//as an exercise increment the y value of p1 (e.g in steps of 3) 
p1 = [120,60];
p2 = [10,90];
p3 = [20,150];

//w determines the width of the line (thickness of the surface)
w = 5; //[0.5:3]

//deltat determines the stepsize of the 'running variable' t. The smaller the step the smoother the curve
deltat = 0.05;

function bezier(p0,p1,p2) = [for (t=[0:deltat:1+deltat]) pow(1-t,2)*p0+2*(1-t)*t*p1+pow(t,2)*p2];
    
function cubic_bezier(p0,p1,p2,p3) = [for (t=[0:deltat:1+deltat]) pow(1-t,3)*p0+3*pow((1-t),2)*t*p1+3*(1-t)*pow(t,2)*p2+pow(t,3)*p3];
    
module line(p1,p2,w) {
    hull() {
        translate(p1) circle(r=w,$fn=20);
        translate(p2) circle(r=w,$fn=20);
    }
}

/*using the, slightly modified, poyline module from JustinSDK (thanks Justin Lin). See his documentation here: https://openhome.cc/eGossip/OpenSCAD/Polyline.html. It's good reading. */
module polyline(points, index, w) {
    if(index < len(points)) {
        line(points[index - 1], points[index],w);
        polyline(points, index + 1, w);
    }
}

/* MAIN */

for (i=[1:30:360]) {
    rotate([0,0,i])
    rotate([90,0,0])
    linear_extrude(4)
    translate([w,0,0])
    polyline(cubic_bezier(p0,p1,p2,p3),1,w);
}
    
//uncomment lines below to create a vase
translate([0,0,-5]) cylinder(r=radius+w,h=9,$fn=50);
rotate_extrude($fn=50)
//polyline(bezier(p0,p1,p2),1,w);
polyline(cubic_bezier(p0,p1,p2,p3),1,1);

