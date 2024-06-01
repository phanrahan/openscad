/*Triangulation of a torus*/

//step determines step size to create matrix.
// The smaller step the larger the matrix.
step=9;

rl=100;
rs=70;

//function to calculate x,y,z for a given vertex (or point) on
// a cone from theta, phi and r,respectively the polar angle,
// azimuthal angle and radius.
function torus(theta,phi,rl,rs)=[(rl+rs*cos(theta))*cos(phi),(rl+rs*cos(theta))*sin(phi),rs*sin(theta)];

//list comprehension that creates a matrix of vertices with 
//horizontally the phi (inner loop) and vertically the theta
// (outer loop) is created.
points=[
    for (theta=[0:step:360])
        [
            for (phi=[0:step:360])
                torus(theta,phi,rl,rs)
        ]
    ];

//reading the matrix of vertices and creating triangles
//hull()
for (theta=[0:len(points)-2])
    for(phi=[0:len(points[theta])-2]) {
        triangle1 =[[points[theta][phi][0],points[theta][phi][1],points[theta][phi][2]],[points[theta+1][phi][0],points[theta+1][phi][1],points[theta+1][phi][2]],[points[theta+1][phi+1][0],points[theta+1][phi+1][1],points[theta+1][phi+1][2]]];
        triangle2 =[[points[theta][phi][0],points[theta][phi][1],points[theta][phi][2]],[points[theta][phi+1][0],points[theta][phi+1][1],points[theta][phi+1][2]],[points[theta+1][phi+1][0],points[theta+1][phi+1][1],points[theta+1][phi+1][2]]];
        polyhedron(triangle1,[[0,1,2]]);
        color("red") 
        polyhedron(triangle2,[[0,1,2]]);
    }

//displaying the vertices
for (theta = [0:step:360]) {
    for (phi = [0:step:360]) {
        point=torus(theta,phi,rl,rs);
        color("green") translate(point) sphere(3);
    }
}


