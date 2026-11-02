// Stepped block with a through slot, reconstructed from the orthographic views.
// Units: mm (proportions measured from the drawing; one grid unit = 10 mm).
// Axes: X = width (left to right in the Front view), Y = depth (front face at Y = 0),
//       Z = height.

W      = 120;  // overall width
D      = 70;   // overall depth
H      = 60;   // height of the tall block
H_low  = 30;   // height of the lower (right) block
W_tall = 40;   // width of the tall block on the left

slot_x = 60;   // slot starts this far from the left end
slot_w = 30;   // slot width
slot_d = 40;   // slot depth, measured back from the front face

eps = 0.01;    // overlap so the cut is clean

difference() {
    union() {
        cube([W_tall, D, H]);        // tall block (left)
        cube([W, D, H_low]);         // lower block (full width)
    }
    // Slot open at the front, running through the full height of the lower block
    translate([slot_x, -eps, -eps])
        cube([slot_w, slot_d + eps, H_low + 2*eps]);
}
