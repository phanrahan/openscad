// The colors are organized into groups, each group anchored by a simple color
//   (e.g., "Black", or "Red") with additional like colors.
all_colors = [

[
"Black",
"DimGray",
"Gray",
"DarkGray",
"Silver",
"LightGrey",
"DarkSlateGray",
"SlateGray",
"LightSlateGray",
],

[
"Brown",
"RosyBrown",
"SandyBrown",
"Goldenrod",
"DarkGoldenrod",
"Peru",
"Chocolate",
"SaddleBrown",
"Sienna",
],

[
"Tan",
"Cornsilk",
"BlanchedAlmond",
"Bisque",
"NavajoWhite",
"Wheat",
"BurlyWood",
"PapayaWhip",
"Moccasin",
"PeachPuff",
],

[
"Red",
"DarkRed",
"Crimson",
"MediumVioletRed",
"PaleVioletRed",
"IndianRed",
"FireBrick",
],

[
"Pink",
"LightPink",
"HotPink",
"DeepPink",
"Magenta",
"DarkMagenta",
"Maroon",
"Fuchsia",
],

[
"Orange",
"OrangeRed",
"DarkOrange",
"Coral",
"LightCoral",
"Tomato",
"Salmon",
"LightSalmon",
"DarkSalmon",
],

[
"Yellow",
"LightYellow",
"Khaki",
"DarkKhaki",
"LemonChiffon",
"LightGoldenrodYellow",
"PaleGoldenrod",
"Gold",
],

[
"Green",
"LightGreen",
"DarkGreen",
"Olive",
"OliveDrab",
"DarkOliveGreen",
"GreenYellow",
"Chartreuse",
"LawnGreen",
"Lime",
"LimeGreen",
"PaleGreen",
"MediumSpringGreen",
"SpringGreen",
"MediumSeaGreen",
"SeaGreen",
"ForestGreen",
"YellowGreen",
"DarkSeaGreen",
"LightSeaGreen",
],

[
"Blue",
"LightBlue",
"DarkBlue",
"SlateBlue",
"MediumSlateBlue",
"DarkSlateBlue",
"SteelBlue",
"LightSteelBlue",
"CadetBlue",
"PowderBlue",
"SkyBlue",
"LightSkyBlue",
"DeepSkyBlue",
"DodgerBlue",
"CornflowerBlue",
"RoyalBlue",
"MediumBlue",
"Navy",
"MidnightBlue",
"Azure",
"AliceBlue",
"Honeydew",
],

[
"Aqua",
"Aquamarine",
"MediumAquamarine",
"Cyan",
"LightCyan",
"DarkCyan",
"Turquoise",
"PaleTurquoise",
"MediumTurquoise",
"DarkTurquoise",
"Teal",
],

[
"Purple",
"MediumPurple",
"Plum",
"Orchid",
"MediumOrchid",
"DarkOrchid",
"Indigo",
"Violet",
"BlueViolet",
"DarkViolet",
"Thistle",
],

[
"White",
"Snow",
"MintCream",
"GhostWhite",
"WhiteSmoke",
"Seashell",
"Beige",
"OldLace",
"FloralWhite",
"Ivory",
"AntiqueWhite",
"Linen",
"LavenderBlush",
"MistyRose",
"Gainsboro",
"Lavender",
],

];

// Draw a small cube for each color, organized into like columns.
// Label each cube, so it's color can be transferred into the SCAD file.
// Each cube is sxs, with s defaulting to one.
module draw_all_colors(s=1) {
    pitch = s * [-5, 0, 1.5];
    text_offset = s * [1.5, 0, 0.3];
    text_scale = s * 0.03;
    num_groups = len(all_colors);
    for (group_index = [0:num_groups-1]) {
        group = all_colors[group_index];
        num_colors = len(group);
        for (color_index = [0:num_colors-1]) {
            c = group[color_index];
            translate(
                    [pitch.x * (group_index+1),
                     pitch.y * 1,
                     pitch.z * color_index]) {
                color(c)
                    cube([s, 0.5*s, s]);
                color("Black")
                    translate(text_offset)
                        rotate([90, 0, 0])
                            scale(text_scale * [1, 1, 1])
                                text(c);
            }
        }
    }
}

draw_all_colors();