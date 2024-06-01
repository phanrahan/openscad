import sys
from svgpathtools import svg2paths, wsvg

svg = sys.argv[1]
pts = sys.argv[2]
print(svg, pts)

# Read SVG into a list of path objects and list of dictionaries of attributes
paths, _ = svg2paths(svg)

path = paths[0]

xmin, xmax, ymin, ymax = path.bbox()
print(xmin,xmax,ymin,ymax)

center = complex((xmin+xmax)/2, (ymin+ymax)/2)
size = max(xmax-xmin, ymax-ymin)


path = path.translated( -center )
path = path.scaled( 50/size )

points = []
for i, line in enumerate(path):
    if i == 0:
        points.append([line.start.real, line.start.imag])
    points.append([line.end.real, line.end.imag])

with open(pts, 'w') as f:
    print( 'points = ', points, ';' , file=f)
