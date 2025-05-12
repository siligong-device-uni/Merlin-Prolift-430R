
// Bearing shape
module Bearing(
    outer, bore, width, 
    raceThickness=1.5, 
    sealClearance=0.4,
    raceColor="#303030",
    sealColor="#903030"
) {
    // Outer race
    color(c=raceColor)
    difference() {
        cylinder(width, d=outer);
        translate([0, 0, -1]) cylinder(width * 2, d=outer - (raceThickness * 2));
    }

    // Inner race
    color(c=raceColor)
    difference() {
        cylinder(width, d=bore + (raceThickness * 2));
        translate([0, 0, -1]) cylinder(width * 2, d=bore);
    }

    // Seal
    color(c=sealColor)
    translate([0, 0, sealClearance]) 
    difference() {
        cylinder(width - (sealClearance * 2), d=outer - (raceThickness * 2));
        translate([0, 0, -1]) cylinder(width * 2, d=bore + (raceThickness * 2));
    }
}


module RPR220PhotoSensor(outline=false, leadSize=0.25, bodyColor="#101010") {
    color(c=bodyColor)
    difference() {
        // Body
        translate([4.9/-2, 6.4/-2, 6.5])
        rotate([-90, 0])
        linear_extrude(6.4)
        polygon([
            [0, 0],
            [0, 6.5 - 1.4],
            [0.35, 6.5],
            [4.9, 6.5],
            [4.9, 0],
        ]);

        // Holes
        if (!outline) {
            translate([0, 1.4, -1]) {
                cylinder(6, d=2);
                translate([-.7, -.4]) 
                    cube([1.4, 1.4, 6]);
            }
            translate([0, -1.4, -1]) {
                cylinder(6, d=2);
                translate([-.7, -1]) 
                    cube([1.4, 1.4, 6]);
            }        
        }

        // Slots
        translate([-.7, 6.4/2 - .1, -1]) 
            cube([1.4, 1.1, 8]);
        translate([-.7, 6.4/-2 - 1, -1]) 
            cube([1.4, 1.1, 8]);

        // Key
        translate([4.9/2, 6.4/2, 6.5/2])
        rotate([0, 0, 45])
        cube([.4, .4, 20], center=true);               
    }

    // Lenses
    translate([0, 1.4, 1])
        color(c="#666699")
        sphere(d=2);
    translate([0, -1.4, 1])
        color(c="#666666")
        sphere(d=2);

    // Leads
    color(c="#f0f0f0") {
        translate([1.25, 1.4, 6.5]) cylinder(d=leadSize, h=10);
        translate([1.25, -1.4, 6.5]) cylinder(d=leadSize, h=10);
        translate([-1.25, 1.4, 6.5]) cylinder(d=leadSize, h=10);
        translate([-1.25, -1.4, 6.5]) cylinder(d=leadSize, h=10);
    }
}


module ITR2001PhotoSensor(outline=false, leadSize=0.25, bodyColor="#101010") {
    width = 6.6;
    depth = 5.1;
    height = 6.5;

    color(c=bodyColor)
    difference() {
        // // Body
        translate([-depth/2, -width/2])
        cube([depth, width,height]);

        // Holes
        if (!outline) {
            translate([0, 1.4, -1]) {
                cylinder(6, d=2);
                translate([-.7, -.4]) 
                    cube([1.4, 1.4, 6]);
            }
            translate([0, -1.4, -1]) {
                cylinder(6, d=2);
                translate([-.7, -1]) 
                    cube([1.4, 1.4, 6]);
            }        
        }
    }

    // Lenses
    translate([0, 1.4, 1])
        color(c="#666699")
        sphere(d=2);
    translate([0, -1.4, 1])
        color(c="#666666")
        sphere(d=2);

    // Leads
    color(c="#f0f0f0") {
        translate([1.25, 1.4, depth]) cylinder(d=leadSize, h=10);
        translate([1.25, -1.4, depth]) cylinder(d=leadSize, h=10);
        translate([-1.25, 1.4, depth]) cylinder(d=leadSize, h=10);
        translate([-1.25, -1.4, depth]) cylinder(d=leadSize, h=10);
    }
}
