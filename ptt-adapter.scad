// ============================================================================
// Electronic Project Enclosure with Sand-Ballast Cavity & Step-Fit Lid
// ============================================================================
// Units: Defined in inches, automatically scaled to millimeters for STL export.
// Coordinate System:
//   X: Left (0) to Right (4.150")
//   Y: Front (0) to Back (2.500")
//   Z: Bottom (0) to Top of assembled lid (1.400")

$fn = 64; // Smoothness for curves and holes

// --- Render View Options ---
//   "assembled" = Transparent lid on box (for visual inspection)
//   "print"     = Box and lid laid flat side-by-side (ready for STL export)
//   "box"       = Box only
//   "lid"       = Lid only
view_mode = "assembled"; 

// --- Master Dimensions (Inches) ---
box_w = 4.150;          // Left to Right (X)
box_d = 2.500;          // Front to Back (Y)
total_h = 1.400;        // Bottom to Top of lid (Z)
wall = 0.150;           // Wall thickness
corner_r = 0.125;       // Exterior corner radius

// --- Bottom & Sand Cavity ---
bot_floor = 0.080;      // Solid bottom shell thickness beneath sand cavity
sand_h = 0.250;         // Sand cavity depth
sand_ceil = 0.100;      // Ceiling thickness above sand cavity
int_floor_z = bot_floor + sand_h + sand_ceil; // Interior floor sits at Z = 0.430"

// --- Silicone Feet Detents ---
foot_d = 0.400;         // Detent diameter
foot_depth = 0.020;     // Shallow recess depth
foot_inset = 0.450;     // Distance from outer edges to center of feet

// --- Lid & Step Interface ---
lid_top_t = 0.100;      // Top plate thickness of the lid
lid_lip_h = 0.065;      // Depth of the step lip dropping into the box (reduced by 0.035")
step_wall = 0.075;      // Half of wall thickness (0.150 / 2)
tol = 0.006;            // Fit clearance (0.006" per side)
box_top_z = total_h - lid_top_t; // Top edge of the box body sits at Z = 1.300"

// --- #4-40 Flathead Machine Screws & Ruthex RX-4-40x5.7 Heat-Set Inserts ---
// Ruthex RX-4-40x5.7 specs: D1 = 4.6mm, D2 = 3.9mm, Recommended Hole D3 = 4.0mm (0.1575"), L = 5.7mm (0.2244")
screw_pilot_d = 0.1575; // 4.0 mm recommended hole diameter for Ruthex RX-4-40x5.7
insert_depth = 0.265;   // 6.7 mm blind hole depth (5.7 mm insert + 1.0 mm plastic displacement relief)
screw_clear_d = 0.120;  // Lid clearance hole for 4-40 machine screw (0.112" major dia)
screw_head_d = 0.230;   // 82-degree flathead countersink diameter
screw_head_h = 0.068;   // 82-degree flathead countersink depth
boss_d = 0.320;         // 8.13 mm boss OD (provides 2.06 mm wall > 1.6 mm Ruthex minimum)
boss_inset = 0.235;     // Screw center distance from outer walls

// --- Internal PCB Riser & Board Stack (Back Wall) ---
pcb_w = 0.750;          // Circuit board / inner riser width (X)
pcb_d = 1.500;          // Total circuit board length front-to-back (Y)
pcb_t = 0.063;          // Circuit board thickness (1.6mm standard FR4)
pcb_slot_depth = 0.075; // Slot depth into back wall (leaves 0.075" to outer back face)
pcb_slot_tol = 0.012;   // Vertical clearance for PCB sliding into slot

riser_h = 0.150;        // Wall height of the 3-sided riser
riser_wall = 0.075;     // Wall thickness of the riser (0.075")
riser_inner_d = pcb_d - pcb_slot_depth; // Depth protruding forward from inner back wall (1.425")

post_w = 0.100;         // Front corner post width/depth
post_h = 0.050;         // Front corner post height above riser floor

// --- Cutouts ---
// Horizontal USB-C (Back Wall, Y = box_d)
usbc_w = 0.355;                                   // Horizontal width along X (~9.0mm)
usbc_h = 0.130;                                   // Vertical height along Z (~3.3mm)
usbc_z = int_floor_z + post_h + pcb_t + usbc_h/2; // Center at Z = 0.608"

// Front Panel Circular Holes for 1/4" Phone Jacks (Front Wall, Y = 0)
front_hole_d = 0.360;
front_hole_spacing = box_w / 3;               // Evenly spaced: 1.383" from edges & each other
front_hole_z = (int_floor_z + box_top_z) / 2; // Centered between interior floor & box top (Z = 0.865")

// --- Miniature SPST Toggle Switch (1/4"-40 Bushing) & Rectangular Body Pocket ---
left_jack_x = box_w/2 - front_hole_spacing/2;  // Center of left-hand 1/4" jack (1.383")
right_jack_x = box_w/2 + front_hole_spacing/2; // Center of right-hand 1/4" jack (2.767")
sw_x = (right_jack_x + box_w) / 2;             // Centered between right jack & right end (3.458")
sw_hole_d = 0.245;                             // Standard 1/4"-40 miniature toggle bushing clearance
sw_body_w = 0.315;                             // Rectangular switch body width (X)
sw_body_h = 0.515;                             // Rectangular switch body height (Z)
sw_pocket_depth = 0.050;                       // Pocket depth into inner front wall (leaves 0.100" wall)


// --- Engraved (Subtractive) Panel Labels ---
label_font = "Liberation Sans:style=Bold";
label_size = 0.130;                        // Main jack & USB-C letter height (~3.3mm)
sw_label_size = 0.105;                     // Switch label letter height (~2.67mm)
label_depth = 0.020;                       // Engraving depth into outer wall (~0.5mm)
front_label_z = front_hole_z - front_hole_d/2 - 0.275; // Centered below front holes (Z = 0.373")
back_label_z = usbc_z - usbc_h/2 - 0.132;              // Centered below USB-C port (Z = 0.411")

// Switch Engraved Label Positions ("Paddles" above, stacked "Key /" & "Keyer" below)
sw_top_label_z = front_hole_z + 0.320;     // Centered above switch ("Paddles", Z = 1.185")
sw_bot_label_z = front_hole_z - 0.320;     // Top line below switch ("Key /", Z = 0.545")
sw_bot_line_spacing = 0.130;               // Vertical spacing between "Key /" and "Keyer"

// Left-Side 4-Line Title Block ("Homebrew" / "PTT / CW" / "USB" / "Serial Adapter")
title_label_size = 0.095;                  // Letter height (~2.41mm) to fit cleanly left of PTT washer
title_line_spacing = 0.155;                // Vertical line-to-line pitch
// Horizontally centered between left corner radius (0.125") and left jack washer outer edge (~1.083")
title_x = (corner_r + (left_jack_x - 0.300)) / 2; // X = 0.604"
// Vertically centered on the front face of the box body (0 to box_top_z = 1.300")
title_center_z = box_top_z / 2;            // Vertical midpoint of 4-line block (Z = 0.650")


// ============================================================================
// Helper Modules
// ============================================================================

module rrect(w, d, r) {
    r_safe = min(r, min(w, d)/2 - 0.0001);
    if (r_safe > 0) {
        offset(r = r_safe)
            offset(delta = -r_safe)
                square([w, d]);
    } else {
        square([w, d]);
    }
}

module usbc_cutout_solid(w, h, depth) {
    span = max(0.001, w - h);
    hull() {
        translate([-span/2, 0, 0])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                cylinder(d = h, h = depth, center = true);
        translate([span/2, 0, 0])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                cylinder(d = h, h = depth, center = true);
    }
}

// ============================================================================
// Main Box Module
// ============================================================================
module enclosure_box() {
    box_body_h = total_h - lid_top_t;
    
    difference() {
        // 1. Main Outer Shell
        linear_extrude(height = box_body_h)
            rrect(box_w, box_d, corner_r);

        // 2. Main Interior Cavity (above sand ceiling)
        translate([wall, wall, int_floor_z])
            linear_extrude(height = box_body_h - int_floor_z + 0.01)
                rrect(box_w - 2*wall, box_d - 2*wall, max(0, corner_r - wall));

        // 3. Enclosed Sand Ballast Cavity (0.250" tall)
        translate([wall, wall, bot_floor])
            linear_extrude(height = sand_h)
                rrect(box_w - 2*wall, box_d - 2*wall, max(0, corner_r - wall));

        // 4. Stepped Rim Cutout (Inner half of wall removed for lid step)
        translate([step_wall, step_wall, box_body_h - lid_lip_h])
            linear_extrude(height = lid_lip_h + 0.01)
                rrect(box_w - 2*step_wall, box_d - 2*step_wall, max(0, corner_r - step_wall));

        // 5. Four Bottom Silicone Feet Detents
        for (x = [foot_inset, box_w - foot_inset]) {
            for (y = [foot_inset, box_d - foot_inset]) {
                translate([x, y, -0.001])
                    cylinder(d = foot_d, h = foot_depth + 0.001);
            }
        }

        // 6. Front Wall Circular Cutouts (2x 1/4" Phone Jacks)
        for (dx = [-front_hole_spacing/2, front_hole_spacing/2]) {
            translate([box_w/2 + dx, -0.01, front_hole_z])
                rotate(a = -90, v = [1.0, 0.0, 0.0])
                    cylinder(d = front_hole_d, h = wall + 0.02);
        }

        // 6b. Front Wall Miniature SPST Toggle Switch & Inner Rectangular Anti-Rotation Pocket
        translate([sw_x, -0.01, front_hole_z])
            rotate(a = -90, v = [1.0, 0.0, 0.0])
                cylinder(d = sw_hole_d, h = wall + 0.02);
        translate([sw_x - sw_body_w/2, wall - sw_pocket_depth, front_hole_z - sw_body_h/2])
            cube([sw_body_w, sw_pocket_depth + 0.01, sw_body_h]);

        // 7. Back Wall Horizontal USB-C Cutout
        translate([box_w/2, box_d - wall/2, usbc_z])
            usbc_cutout_solid(usbc_w, usbc_h, wall + 0.06);

        // 8. Back Wall Recessed PCB Slot (0.075" deep into inner back wall)
        slot_w = pcb_w + 0.010;
        slot_h = pcb_t + pcb_slot_tol;
        slot_z = int_floor_z + post_h - pcb_slot_tol/2;
        translate([box_w/2 - slot_w/2, box_d - wall - 0.01, slot_z])
            cube([slot_w, pcb_slot_depth + 0.01, slot_h]);

        // 9. Front Panel Engraved Labels ("PTT" under left hole, "Key" under right hole)
        translate([left_jack_x, label_depth, front_label_z])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                linear_extrude(height = label_depth + 0.005)
                    text("PTT", size = label_size, font = label_font, halign = "center", valign = "center");

        translate([right_jack_x, label_depth, front_label_z])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                linear_extrude(height = label_depth + 0.005)
                    text("Key", size = label_size, font = label_font, halign = "center", valign = "center");

        // 9b. Switch Engraved Labels ("Paddles" above switch, stacked "Key /" & "Keyer" below)
        translate([sw_x, label_depth, sw_top_label_z])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                linear_extrude(height = label_depth + 0.005)
                    text("Paddles", size = sw_label_size, font = label_font, halign = "center", valign = "center");

        translate([sw_x, label_depth, sw_bot_label_z])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                linear_extrude(height = label_depth + 0.005)
                    text("Key /", size = sw_label_size, font = label_font, halign = "center", valign = "center");

        translate([sw_x, label_depth, sw_bot_label_z - sw_bot_line_spacing])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                linear_extrude(height = label_depth + 0.005)
                    text("Keyer", size = sw_label_size, font = label_font, halign = "center", valign = "center");

        // 9c. Left-Side 4-Line Title Block ("Homebrew" / "PTT / CW" / "USB" / "Serial Adapter")
        title_lines = ["Homebrew", "PTT / CW", "USB", "Serial Adapter"];
        for (i = [0 : 3]) {
            line_z = title_center_z + (1.5 - i) * title_line_spacing;
            translate([title_x, label_depth, line_z])
                rotate(a = 90, v = [1.0, 0.0, 0.0])
                    linear_extrude(height = label_depth + 0.005)
                        text(title_lines[i], size = title_label_size, font = label_font, halign = "center", valign = "center");
        }

        // 10. Back Panel Engraved Label ("USB-C" centered under USB-C cutout)
        translate([box_w/2, box_d - label_depth, back_label_z])
            rotate(a = 90, v = [1.0, 0.0, 0.0])
                rotate(a = 180, v = [0.0, 1.0, 0.0])
                    linear_extrude(height = label_depth + 0.005)
                        text("USB-C", size = label_size, font = label_font, halign = "center", valign = "center");
    }

    // --- Internal Features Added Back Inside Cavity ---
    
    // 11. Cylindrical Corner Screw Bosses (Flush with step shelf, sized for Ruthex RX-4-40x5.7)
    boss_top_z = box_body_h - lid_lip_h;
    boss_h = boss_top_z - int_floor_z;
    
    for (sx = [boss_inset, box_w - boss_inset]) {
        for (sy = [boss_inset, box_d - boss_inset]) {
            difference() {
                translate([sx, sy, int_floor_z])
                    cylinder(d = boss_d, h = boss_h);
                // Ruthex RX-4-40x5.7 Blind Pilot Hole
                translate([sx, sy, boss_top_z - insert_depth])
                    cylinder(d = screw_pilot_d, h = insert_depth + 0.01);
            }
        }
    }

    // 12. Three-Sided PCB Riser Centered on Back Wall (0.075" wall thickness)
    riser_outer_w = pcb_w + 2 * riser_wall;
    riser_outer_d = riser_inner_d + riser_wall;
    rx = (box_w - riser_outer_w) / 2;
    ry = box_d - wall - riser_outer_d;
    
    translate([rx, ry, int_floor_z]) {
        cube([riser_wall, riser_outer_d, riser_h]);
        translate([riser_outer_w - riser_wall, 0, 0])
            cube([riser_wall, riser_outer_d, riser_h]);
        cube([riser_outer_w, riser_wall, riser_h]);
        
        for (px = [riser_wall, riser_wall + pcb_w - post_w]) {
            translate([px, riser_wall, 0])
                cube([post_w, post_w, post_h]);
        }
    }
}

// ============================================================================
// Lid Module (Top)
// ============================================================================
module enclosure_lid() {
    difference() {
        union() {
            // 1. Top Plate (matches outer box profile)
            translate([0, 0, lid_lip_h])
                linear_extrude(height = lid_top_t)
                    rrect(box_w, box_d, corner_r);

            // 2. Stepped Lip (nests inside box rim with tolerance)
            lip_offset = step_wall + tol;
            translate([lip_offset, lip_offset, 0])
                linear_extrude(height = lid_lip_h + 0.001)
                    rrect(box_w - 2*lip_offset, box_d - 2*lip_offset, max(0, corner_r - lip_offset));
        }

        // 3. Four #4-40 Flathead Countersunk Screw Holes
        for (sx = [boss_inset, box_w - boss_inset]) {
            for (sy = [boss_inset, box_d - boss_inset]) {
                translate([sx, sy, -0.01])
                    cylinder(d = screw_clear_d, h = lid_lip_h + lid_top_t + 0.02);
                translate([sx, sy, lid_lip_h + lid_top_t - screw_head_h])
                    cylinder(d1 = screw_clear_d, d2 = screw_head_d, h = screw_head_h + 0.005);
            }
        }
    }
}

// ============================================================================
// Assembly & Export Rendering (Scaled to Millimeters)
// ============================================================================
scale([25.4, 25.4, 25.4]) {
    if (view_mode == "assembled") {
        enclosure_box();
        %translate([0, 0, total_h - lid_top_t - lid_lip_h])
            enclosure_lid();
    } 
    else if (view_mode == "print") {
        enclosure_box();
        translate([box_w + 0.5, box_d, lid_top_t + lid_lip_h])
            rotate(a = 180, v = [1.0, 0.0, 0.0])
                enclosure_lid();
    } 
    else if (view_mode == "box") {
        enclosure_box();
    } 
    else if (view_mode == "lid") {
        translate([0, box_d, lid_top_t + lid_lip_h])
            rotate(a = 180, v = [1.0, 0.0, 0.0])
                enclosure_lid();
    }
}
