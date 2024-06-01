/*Triangulation of a cylinder*/

//step determines step size to create matrix.
// The smaller step the larger the matrix.
step=9;
//r is the radius in the 3d_sphere function
r = 15;
//h determines the height of the cone 
h=30;

//function to calculate x,y,z for a given vertex (or point) on
// a cone from u, phi and r,respectively the polar angle,
// azimuthal angle and radius.
function 3d_cylinder(phi,r,u)=[r*cos(phi),r*sin(phi),u];

//list comprehension that creates a matrix of vertices with 
//horizontally the phi (inner loop) and vertically the u
// (outer loop) is created.
points=[
    for (u=[0:3:h])
        [
            for (phi=[0:step:360])
                3d_cylinder(phi,r,u)
        ]
    ];

//reading the matrix of vertices and creating triangles
//hull()
for (u=[0:len(points)-2])
    for(phi=[0:len(points[u])-2]) {
        triangle1 =[[points[u][phi][0],points[u][phi][1],points[u][phi][2]],[points[u+1][phi][0],points[u+1][phi][1],points[u+1][phi][2]],[points[u+1][phi+1][0],points[u+1][phi+1][1],points[u+1][phi+1][2]]];
        triangle2 =[[points[u][phi][0],points[u][phi][1],points[u][phi][2]],[points[u][phi+1][0],points[u][phi+1][1],points[u][phi+1][2]],[points[u+1][phi+1][0],points[u+1][phi+1][1],points[u+1][phi+1][2]]];
        polyhedron(triangle1,[[0,1,2]]);
        color("red") 
        polyhedron(triangle2,[[0,1,2]]);
    }
