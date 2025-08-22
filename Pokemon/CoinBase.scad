// Base coin module
// Raised text and thin outer edge on top side

$fn = 100; // Smooth curves

module coin(
    diameter,        // Coin diameter in mm
    thickness,       // Coin thickness in mm
    text,            // Text on the coin
    text_size,       // Text size
    raised_height,   // Height of both text and edge
    edge_width       // Width of outer edge
) {
    union() {
        // Base coin
        cylinder(h = thickness, d = diameter);
        
        // Raised text on top
        translate([0, 0, thickness])
        linear_extrude(height = raised_height)
        text(text, font = "Arial:style=Bold", size = text_size, halign = "center", valign = "center");
        
        // Thin outer edge on top
        translate([0, 0, thickness])
        difference() {
            cylinder(h = raised_height, d = diameter);
            cylinder(h = raised_height + 0.1, d = diameter - edge_width * 2);
        }
    }
}
