include <coral.pts>;

use <scad-utils/transformations.scad>
use <list-comprehension-demos/sweep.scad>

function bezier(t,p0,p1,p2) = pow(1-t,2)*p0+2*(1-t)*t*p1+pow(t,2)*p2;

function cubic_bezier(t,p0,p1,p2,p3) = pow(1-t,3)*p0+3*pow((1-t),2)*t*p1+3*(1-t)*pow(t,2)*p2+pow(t,3)*p3;

// scaling the width
p0 = 1.3;
p1 = 2.0;
p2 = 3.5;
p3 = 2.0;

height = 120;

transforms = [for (i=[0:1:height]) 
                let(s=cubic_bezier(i/height,p0,p1,p2,p3)) 
                   translation([0,0,i]) * scaling([s,s,s])];

sweep(points, transforms);


