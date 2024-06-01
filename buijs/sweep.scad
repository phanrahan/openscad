/* This script demonstrates the 2D supershapes. See http://paulbourke.net/geometry/supershape for the equation and more information about it.
The 2D supershape equation is an extension of the general ellipse equation. The equation uses polar coordinates, radius and theta in this script.
*/

use <scad-utils/transformations.scad>
use <list-comprehension-demos/sweep.scad>

function bezier(t,p0,p1,p2) = pow(1-t,2)*p0+2*(1-t)*t*p1+pow(t,2)*p2;

function cubic_bezier(t,p0,p1,p2,p3) = pow(1-t,3)*p0+3*pow((1-t),2)*t*p1+3*(1-t)*pow(t,2)*p2+pow(t,3)*p3;

// scaling the width
p0 = 1.0;
p1 = 1.5;
p2 = 2.5;
p3 = 2.0;

height = 120;
radius = 20;

//a and b are not 0
a = 1;
b = 1;

//m = 0 returns a circle. 
m = 12  ;
n1 = 4;
n2 = 3;
n3 = 3;


//range_multiplier integer larger than 0 but mostly 1
//larger that 1 extends angle theta
//for some shapes theta needs to be extended to 12pi (ext = 6)
range_multiplier = 1;

//equation of the 2D supershape results in 1/r for a given theta
function superformula(theta) = pow(pow(abs(1 / a * cos(m/4*theta)),n2)+ pow(abs(1 / a * sin(m/4*theta)),n3), 1 / n1);

//function calculates supershape function for a number of angles,
//using x = r cos(theta) and y = r sin(theta),
//and returns the x and y coordinates in a list
function supershape(range_multiplier) = [for (theta = [0:1:360 * range_multiplier]) [radius/superformula(theta) * cos(theta), radius/superformula(theta) * sin(theta)] ];


points = supershape(range_multiplier);


transforms = [for (i=[0:1:height]) 
                let(s=cubic_bezier(i/height,p0,p1,p2,p3)) 
                   translation([0,0,i]) * scaling([s,s,s])];

sweep(points, transforms);

//linear_extrude(5) polygon(points);

