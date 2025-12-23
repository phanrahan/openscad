import string
from collections import OrderedDict
from itertools import count

# precision of output points
decimals = 2

svg = '''M0,0 L66,0 L66,140 L0,140 L0,0 Z M17.5356193,9.91374504 L7.89629934,9.91374504 L7.89629934,34.6390567 L13.9842872,34.6390567 L13.9842872,27.741635 L17.6136633,27.741635 C21.6461094,27.741635 24.6445573,27.0341777 26.6090071,25.619263 C28.5734569,24.2043483 29.555612,21.9699927 29.5554723,18.9161962 C29.5554723,15.8625389 28.5993435,13.5986987 26.687086,12.1246754 C24.7748285,10.6511862 21.7243396,9.91420937 17.5356193,9.91374504 Z M51.2530562,20.2426569 L40.4040722,20.2426569 L40.4040722,9.91374504 L34.3159446,9.91374504 L34.3159446,34.6392308 L40.4040722,34.6390567 L40.4040722,24.9118057 L51.2530562,24.9118057 L51.2530562,34.6392308 L57.3411838,34.6392308 L57.3411838,9.91374504 L51.2530562,9.91391916 L51.2530562,20.2426569 Z'''

def string_to_point_tuple(s):
	# given '0,0', return (0,0)
	a,b = s.split(',')
	return (float(a),float(b))

# encapsulates a single SVG command string with computed properties
# to derive the command name (the first letter) and the parameter list
# (given as a list of tuples of floats)
class SVGCommand:
	def __init__(self, command_string):
		self.command_string = command_string
		
	@staticmethod
	def line_to(point):
		return SVGCommand(f'L{point[0]},{point[1]}')

	@property
	def command_letter(self):
		return self.command_string[:1]

	@property
	def command_name(self):
		return {
			'M': 'move cursor to',
			'L': 'draw a line to',
			'Z': 'close the path',
			'C': 'draw a Bézier curve'
		}[self.command_letter]

	@property
	def parameters(self):
		params = self.command_string[1:].split(' ')
		if params == ['']:
			return []
		else:
			return list(map(string_to_point_tuple, params))

	def __repr__(self):
		return f'SVG ({self.command_name} {self.parameters})'

# turn an SVG command list string into SVGCommand objects
def commands(s):
	buf = ''
	in_command = False
	for char in s:
		alpha = char.isalpha()
		# 0 0
		# beginning of SVG command string, first character must be alpha
		if not in_command and not alpha:
			raise ValueError('Not yet inside of a command, expected an SVG command indicator.')
		# 0 1
		# beginning of SVG command string, first character must be alpha
		# begin accumulating command
		elif not in_command and alpha:
			in_command = True
			buf += char
		# 1 0
		# in SVG command, continuing accumulation
		elif in_command and not alpha:
			buf += char
		# 1 1
		# new command beginning
		elif in_command and alpha:
			yield SVGCommand(buf.strip())
			buf = char
	# end of iteration
	if buf != '':
		yield SVGCommand(buf.strip())

'''
M - move cursor without drawing, absolute (uppercase)

L - push the cursor position to the point list, then the given point (drawing a straight line),
    followed by updating the cursor to the given point. Absolute.

Z - close the path (draw a line to the first point)

C - Bézier curve. Syntax "C p1 p2 p3". Given the cursor as "p0", draw a Bézier curve beginning at
    p0 and ending at p3, with p1 as the Bézier anchor for the start and p2 as the Bézier anchor for the end.
'''

# given an SVGCommand object, returns the same object unaltered,
# unless it is a Bezier command, which it will replace with a line
# draw command (lossy). This is a placeholder for a Bezier interpolation
# tool.
def strip_bezier(c):
	if c.command_letter == BEZIER_CURVE:
		end_point = c.parameters[2]
		return SVGCommand(f'L{end_point[0]},{end_point[1]}')
	return c
	
def interpolate_bezier_curves(cs):
	for i,c in enumerate(cs):
		# return other commands unchanged
		if c.command_letter != BEZIER_CURVE:
			yield c
			continue
		# for Bézier commands, interpolate
		# 'C' command: SVG `curveto` (Cubic Bézier)
		
		# a Cubic Bézier curve has four points: p0, p1, p2, p3
		
		p0 = cs[i-1].parameters[-1] # the cursor, starting point
		p1 = c.parameters[0] # the start anchor
		p2 = c.parameters[1] # the end anchor
		p3 = c.parameters[2] # the end point
		
		# [CITE] https://en.wikipedia.org/wiki/Bézier_curve#Cubic_Bézier_curves, "the explicit form"
		B = lambda _0, _1, _2, _3, t: \
			(1-t)**3 * _0 + \
			3 * (1-t)**2 * t * _1 + \
			3 * (1-t) * t**2 * _2 + \
			t**3 * _3
		
		Bx = lambda t: B(p0[0],p1[0],p2[0],p3[0],t)
		By = lambda t: B(p0[1],p1[1],p2[1],p3[1],t)
		
		# 0 <= t <= 1
		ts = list(map(lambda x: x*0.1, range(11)))
		
		for t in ts:
			yield SVGCommand.line_to(
				(Bx(t), By(t))
			)
		
		# dummy: yield one point
#		end = c.parameters[-1]
#		yield SVGCommand(f'L{end[0]},{end[1]}')	
		

MOVE_CURSOR = 'M'
DRAW_LINE = 'L'
CLOSE_PATH = 'Z'
BEZIER_CURVE = 'C'

last_close = None
cursor = None

# we use this first to unique all the points used
# we basically abuse this to act like an OrderedSet
all_points = OrderedDict()
# a dict of point tuples to integer indices
point_to_index = dict()
next_index = 0

cs = list(commands(svg))

# handle bezier curves (OpenSCAD cannot)
# this option replaces bezier curves with single points
#cs = list(map(strip_bezier, cs))
# this option replaces bezier curves with multiple interpolated
# points
cs = list(interpolate_bezier_curves(cs))

# summarize points
# OpenSCAD polygons can just be lists of points,
# but complex forms need a list of points and a list of indices
# to describe cyclical paths with subtractive surfaces
for command in cs:
	for point in command.parameters:
		all_points[point] = 1 # useless value

point_to_index = dict(zip(all_points.keys(), count()))

index = lambda point: point_to_index[point]

paths = [[]]

for c in cs:
	letter = c.command_letter
	if letter == MOVE_CURSOR:
#		print(f'• Move cursor to {index(c.parameters[0])}')
		cursor = c.parameters[0]
		paths[-1].append(index(cursor))
	elif letter == DRAW_LINE:
#		print(f'• Line from {index(cursor)} to {index(c.parameters[0])}')
		cursor = c.parameters[0]
		paths[-1].append(index(cursor))
	elif letter == CLOSE_PATH:
#		print('• Close the path\n')
		paths[-1].append(paths[-1][0])
		paths.append([])
	elif letter == BEZIER_CURVE:
		pass
#		print(f'• Bézier curve from {point_to_index[cursor]} to {point_to_index[c.parameters[2]]}')
#		print(f'    Anchors: {point_to_index[c.parameters[0]]}')
#		print(f'             {point_to_index[c.parameters[1]]}')

if paths[-1] == []:
	paths = paths[:-1]

point_strings = []
for point in point_to_index.keys():
	point_strings.append(f'\t\t[{point[0]:.{decimals}f},{point[1]:.{decimals}f}]')
point_string = ',\n'.join(point_strings)

path_strings = list(map(lambda x: f'\t\t{x}', paths))
path_string = ',\n'.join(path_strings)

print(
    f'polygon(\n\tpoints=[\n{point_string}\n\t],'
    f'\n\tpaths=[\n{path_string}\n\t],\n\tconvexity=2\n);'
)
		