$fn = 64;

difference() {
    cube([10, 20, 10]);
    
    translate([5, -1, 5])
        rotate([-90, 0, 0])
            cylinder(h=22, d=4.7);
}
