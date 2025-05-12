include <lib/gears.scad>
include <components.scad>

$fn = 90;

/* [Encoder Gear config] */
gearThickness = 1.5;

/* [Bearing config] */

// Diameter of bearing
bearingDiameter = 22;
// Height of bearing
bearingHeight = 7;
// Diameter of bearing shaft
bearingShaftDiameter = 8;

/* [Quadrature config] */

// Number of Quadrature Steps
stepCount = 12;  // [8:120]
// Diameter of A ring
quadDiameter = 19.5;


module timing_ring(stepAngle, radius, width=1, height=2) {
    for (n=[0:stepAngle * 2:360]) {
        rotate([0, 0, n]) {
            rotate_extrude(angle=stepAngle) {
                translate([radius, 0])
                    square([width, height], center=true);
            }
        }
    }
}

module encoderGear(show_gear = true) {
    difference() {
        cylinder(h=gearThickness, r=27);
        translate([0, 0, -1]) {
            // Bearing ring
            cylinder(h=7, d=bearingDiameter-2, center=true);
            timing_ring(360 / stepCount, quadDiameter, width=7, height=8);
        }
    }
    // Bearing mount
    difference() {
        cylinder(d1=bearingDiameter+5, d2=bearingDiameter+3, h=bearingHeight+gearThickness);
        translate([0, 0, -1]) cylinder(d=bearingDiameter, h=30, center=true);
    }
    // Gear Ring
    if (show_gear)
        difference() {
            spur_gear(modul = 3.2, tooth_number = 20, width = 5, bore = 5);
            translate([0, 0, -1]) cylinder(r1=26, r2=27, h=30);
        }
}

module encoderGearBacking() {
    difference() {
        union() {
            cylinder(h=gearThickness, r=27);
            translate([0, 0, gearThickness]) {
                cylinder(h=gearThickness*2, d=bearingDiameter-2.025, center=true);
            }
        }
        cylinder(h=20, d=bearingDiameter-3, center=true);
    }
}

module encoderMount() {
    difference() {
        union() {
            // Photosensor mount
            rotate([0, 0, -15])
                rotate_extrude(angle=135)
                    polygon([
                        [quadDiameter - 5, 0],
                        [quadDiameter + 5, 0],
                        [quadDiameter + 6, bearingHeight],
                        [quadDiameter - 5, bearingHeight],
                    ]);
                
            // Shoud
            rotate([0, 0, -92]) {
                rotate_extrude(angle=227)
                    polygon([
                        [quadDiameter - 5, bearingHeight],
                        [quadDiameter - 5, bearingHeight + 5],
                        [38, bearingHeight + 5],
                        [38, bearingHeight - 2],
                    ]);
                rotate_extrude(angle=227)
                    polygon([
                        [37, bearingHeight],
                        [38, bearingHeight],
                        [38, -4],
                        [37, -4],
                    ]);
            }

            // Base
            difference() {
                rotate_extrude(angle=135)
                    polygon([
                        [38, bearingHeight + 5],
                        [38, -4],
                        [60, -4],
                        [60, bearingHeight + 5],
                    ]);
                translate([38, -10, -5])
                    cube([60, 100, 20]);
                translate([-60, 38, -5])
                    cube([200, 100, 20]);
                translate([-60, 0, -5])
                    cube([33, 100, 20]);
            }

            // Shaft Holder
            translate([0, 0, bearingHeight])
                cylinder(h=5, r=quadDiameter - 5);
            translate([0, 0, bearingHeight-.4])
                cylinder(h=.4, d=bearingShaftDiameter + 4);

            // Bolt Mount
            translate([0, -39.5, -4]) cylinder(h=16, d=6);
        }

        // Shaft hole
        translate([0, 0, -1]) cylinder(20, d=bearingShaftDiameter);

        // Mounts
        rotate([0, 0, 15])
            translate([quadDiameter, 0, -.2]) rotate([0, 0, 90]) ITR2001PhotoSensor(true, 2);
        rotate([0, 0, 90])
            translate([quadDiameter, 0, -.2]) rotate([0, 0, 90]) ITR2001PhotoSensor(true, 2);

        // Bolts
        translate([34, 34, -10]) cylinder(80, d=3);
        translate([-23, 34, -10]) cylinder(80, d=3);
        translate([0, -39.5, -10]) cylinder(80, d=3);
    }
}

module encodeBackplate() {
    difference() {
        union() {
            // Shaft Holder
            translate([0, 0, -5])
                cylinder(h=4, r=quadDiameterA - 3);
               
            // Shoud
            rotate([0, 0, -92]) {
                rotate_extrude(angle=227)
                    polygon([
                        [0, -5],
                        [38, -5],
                        [38, 0],
                        [37, 0],
                        [37, -3],
                        [quadDiameterA - 3, -3],
                    ]);

            }               

            // Base
            difference() {
                rotate_extrude(angle=135)
                    polygon([
                        [38, 0],
                        [38, -5],
                        [60, -5],
                        [60, 0],
                    ]);
                translate([38, -10, -6])
                    cube([60, 100, 20]);
                translate([-60, 38, -6])
                    cube([200, 100, 20]);
                translate([-60, 0, -6])
                    cube([33, 100, 20]);
            }

            // Bolt Mount
            translate([0, -39.5, -5]) cylinder(h=5, d=6); 
        }

        // Shaft hole
        translate([0, 0, -19]) cylinder(20, d=bearingShaftDiameter);

        // Bolts
        translate([34, 34, -10]) cylinder(80, d=3);
        translate([-23, 34, -10]) cylinder(80, d=3);
        translate([0, -39.5, -10]) cylinder(80, d=3);
    }
}

// Encoder wheel
// translate([0, 0, -gearThickness]) color(c="#fff") encoderGearBacking();
color(c="#444") encoderGear(show_gear=true);

// translate([0, 0, gearThickness]) Bearing(bearingDiameter, bearingShaftDiameter, bearingHeight);
// rotate([0, 0, 15]) translate([quadDiameter, 0, 2.2]) rotate([0, 0, 90]) ITR2001PhotoSensor();
// rotate([0, 0, 90]) translate([quadDiameter, 0, 2.2]) rotate([0, 0, 90]) ITR2001PhotoSensor();
// translate([0, 0, 1.8]) 
//     encoderMount();
// translate([0, 0, -20])
// encodeBackplate();