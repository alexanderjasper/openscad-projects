$fn = 64;

width = 40;
length = 90;
height = 23;
hole_position = [width/2, height/2];
screw_hole_depth = 40;

render() {
  difference() {
    cube([width, length, height]);

    // Wall screw hole
    translate([hole_position[0], length - screw_hole_depth, hole_position[1]])
      rotate([-90, 0, 0])
        cylinder(h=screw_hole_depth, d=6);

    // Countersink for wall screw
    translate([hole_position[0], length - screw_hole_depth - 3, hole_position[1]])
      rotate([-90, 0, 0])
        cylinder(h=3, d1=10, d2=6);
    
    // Wall screw hole - wide part
    translate([hole_position[0], length - screw_hole_depth - 3 - 5, hole_position[1]])
      rotate([-90, 0, 0])
        cylinder(h=5, d=10);

    // Wall screw access cavity - wide part
    translate([hole_position[0], length - screw_hole_depth - 3 - 5, hole_position[1] -(10/2)])
      cube([width, 5, 10]);
    
    // Wall screw access cavity - narrow part
    translate([hole_position[0], length - screw_hole_depth - 3, hole_position[1] -(6/2)])
      cube([width, screw_hole_depth + 3, 6]);

    // M5 screw hole
    translate([hole_position[0], 0, hole_position[1]])
      rotate([-90, 0, 0])
        cylinder(h=length, d=4.7);
  }
}
