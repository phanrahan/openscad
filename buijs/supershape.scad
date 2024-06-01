/* This script demonstrates the 2D supershapes. See http://paulbourke.net/geometry/supershape for the equation and more information about it.
The 2D supershape equation is an extension of the general ellipse equation. The equation uses polar coordinates, radius and theta in this script.
*/

//a and b are real numbers but not 0
a = 1;
b = 1;

//real number, m = 0 returns a circle. 
m = 5  ;
  
//real numbers
n1 = 0.02;
n2 = 1.7;
n3 = 1.7;

//radius of the shape. Larger results in larger shape
radius = 30;

//range_multiplier integer larger than 0 but mostly 1
//larger that 1 extends angle theta
//for some shapes theta needs to be extended to 12pi (ext = 6)
range_multiplier = 1;

//equation of the 2D supershape results in 1/r for a given theta
//(polar coordinates)
function superformula(theta) = pow(pow(abs(1 / a * cos(m/4*theta)),n2)+ pow(abs(1 / a * sin(m/4*theta)),n3), 1 / n1);

//function calculates supershape function for a number of angles,
//using x = r cos(theta) and y = r sin(theta),
//and returns the x and y coordinates in a list
function supershape(range_multiplier) = [for (theta = [0:1:360 * range_multiplier]) [radius/superformula(theta) * cos(theta), radius/superformula(theta) * sin(theta)] ];

//draw the x,y coordinates calculates in the function super
echo(supershape(range_multiplier));
polygon(supershape(range_multiplier));

