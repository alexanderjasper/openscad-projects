$fn = 64;
render() {
  difference() {
    cube([20, 90, 28]);

    // Wall screw hole
    translate([10, -1, 10])
      rotate([-90, 0, 0])
        cylinder(h=92, d=6);
    // Wall screw hole - wide part
    translate([10, -1, 10])
      rotate([-90, 0, 0])
        cylinder(h=41, d=10);
    // Countersink for wall screw
    translate([10, 40, 10])
      rotate([-90, 0, 0])
        cylinder(h=3, d1=10, d2=6);

    // M5 screw hole
    translate([10, -1, 18])
      rotate([-90, 0, 0])
        cylinder(h=41, d=4.7);
  }
}
