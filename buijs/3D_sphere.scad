/* 3D sphere made out of triangles.
Sources: https://openhome.cc/eGossip/OpenSCAD/FunctionGrapher.html from Justin Lin. BTW openhome.cc is a great website if you want to advance in OpenSCAD.
https://www.youtube.com/watch?v=RkuBWEkBrZA&t=822s from Daniel Schiffmann's entertaining Coding Train channel.
*/
step=4.5;
r = 100;

function vr(theta)=r*sin(theta);

//function to calculate x,y,z for a given vertex (or point) on
// a sphere from theta, phi and r,respectively the polar angle,
// azimuthal angle and radius.
function 3d_sphere(theta,phi,r)=[r*sin(theta)*cos(phi),r*sin(theta)*sin(phi),r*cos(theta)];

//function 3dv_sphere(theta,phi)=[vr(theta)*sin(theta)*cos(phi),vr(theta)*sin(theta)*sin(phi),vr(theta)*cos(theta)];


//list comprehension that creates a matrix of vertices with 
//horizontally the phi (inner loop) and vertically the theta
// (outer loop) is created.
points=[
    for (theta=[0:step:180])
        [
            for (phi=[0:step:360])
                3d_sphere(theta,phi,r)
                //3dv_sphere(theta,phi)
        ]
    ];

/*
//reading the matrix of vertices and creating triangles
//hull()
for (theta=[0:len(points)-2])
    for(phi=[0:len(points[theta])-2]) {
        triangle1 =[[points[theta][phi][0],points[theta][phi][1],points[theta][phi][2]],[points[theta+1][phi][0],points[theta+1][phi][1],points[theta+1][phi][2]],[points[theta+1][phi+1][0],points[theta+1][phi+1][1],points[theta+1][phi+1][2]]];
        triangle2 =[[points[theta][phi][0],points[theta][phi][1],points[theta][phi][2]],[points[theta][phi+1][0],points[theta][phi+1][1],points[theta][phi+1][2]],[points[theta+1][phi+1][0],points[theta+1][phi+1][1],points[theta+1][phi+1][2]]];
 //       echo(triangle1);
  //      echo(triangle2);
        polyhedron(triangle1,[[0,1,2]]);
        color("red")
        polyhedron(triangle2,[[0,1,2]]);
    }
*/
            
//displaying the vertices
for (theta = [0:step:180]) {
    for (phi = [0:step:360]) {
        point=3d_sphere(theta,phi,r);
        color("green") translate(point) sphere(1);
    }
}

