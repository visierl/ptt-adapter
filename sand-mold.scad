// ============================================================================
// Kinetic Sand Ballast Preform Mold & Drop-Transfer Jig (With Stabilizer Track)
// ============================================================================
// Units: Defined in inches, automatically scaled to millimeters for STL export.
// Aluminum Plate Size: Cut 0.030" sheet to 4.080" wide x ~3.500" long.

$fn = 64; // Smoothness for outer corner radii

// --- Render View Options ---
//   "print"  = Mold body and pusher plunger side-by-side (ready for STL export)
//   "mold"   = Drop-mold jig only
//   "pusher" = Optional tamper/pusher block only
view_mode = "print";

// --- Matching Enclosure Reference Dimensions (Inches) ---
box_w = 4.150;          // Enclosure outer width (X)
box_d = 2.500;          // Enclosure outer depth (Y)
box_wall = 0.150;       // Enclosure wall thickness
box_corner_r = 0.125;   // Enclosure outer corner radius
sand_h = 0.250;         // Enclosure sand cavity depth

// --- Sand Slug Clearances ---
slug_side_inset = 0.015; // Inset on all 4 interior sides from cavity wall (0.015")
slug_h_inset = 0.020;    // Shallower than cavity depth (0.250" - 0.020" = 0.230")

// Computed Sand Slug Dimensions:
cav_w = box_w - 2 * box_wall;           // 3.850"
cav_d = box_d - 2 * box_wall;           // 2.200"
slug_w = cav_w - 2 * slug_side_inset;   // 3.820"
slug_d = cav_d - 2 * slug_side_inset;   // 2.170"
slug_h = sand_h - slug_h_inset;         // 0.230"

// --- 0.030" Sheet Aluminum Stabilizer Track & Leak Seal ---
plate_t = 0.030;         // Aluminum sheet thickness
plate_z_tol = 0.004;     // Snug vertical clearance to prevent sand leakage (0.034" slot)
slot_h = plate_t + plate_z_tol;
slot_groove = 0.140;     // Deep 3-sided groove (left, right, rear) for plate stability
slot_chamfer = 0.025;    // Front entry bevel for easy plate insertion

// --- Alignment Skirt & Mold Body ---
skirt_h = 0.150;         // Depth of outer alignment skirt gripping the paused box
skirt_tol = 0.018;       // Slip-fit clearance around paused box (per side)
skirt_wall = 0.120;      // Outer wall thickness (leaves 0.130" solid wall behind groove)

// --- Pusher / Tamper Block ---
pusher_tol = 0.020;      // Clearance inside mold cavity so pusher slides freely
pusher_base_h = 0.280;   // Tall enough to push slug flush onto enclosure floor
pusher_handle_h = 0.400;


// ============================================================================
// Helper Module
// ============================================================================
module rrect_centered(w, d, r) {
    r_safe = min(r, min(w, d)/2 - 0.0001);
    translate([-w/2, -d/2]) {
        if (r_safe > 0) {
            offset(r = r_safe)
                offset(delta = -r_safe)
                    square([w, d]);
        } else {
            square([w, d]);
        }
    }
}

// ============================================================================
// Drop-Mold Jig Module
// ============================================================================
module sand_drop_mold() {
    outer_w = box_w + 2 * skirt_tol + 2 * skirt_wall;
    outer_d = box_d + 2 * skirt_tol + 2 * skirt_wall;
    outer_r = box_corner_r + skirt_tol + skirt_wall;
    
    // Z-levels from bottom of alignment skirt (Z = 0):
    //   0.000" -> 0.150": Open alignment pocket over paused box
    //   0.150" -> 0.184": Deep 3-sided aluminum stabilizer track (0.140" groove)
    //   0.184" -> 0.414": Preformed sand slug cavity (0.230" tall)
    slot_bot_z = skirt_h;
    slug_bot_z = slot_bot_z + slot_h;
    total_mold_h = slug_bot_z + slug_h;

    slot_w = slug_w + 2 * slot_groove; // 4.100" groove-to-groove span
    slot_d = outer_d/2 + slug_d/2 + slot_groove;

    translate([0, 0, total_mold_h]) rotate([0, 180, 0]) difference() {
        // 1. Main Outer Block
        linear_extrude(height = total_mold_h)
            rrect_centered(outer_w, outer_d, outer_r);

        // 2. Bottom Alignment Skirt Pocket (slips over paused enclosure walls)
        translate([0, 0, -0.001])
            linear_extrude(height = skirt_h + 0.001)
                rrect_centered(box_w + 2 * skirt_tol, box_d + 2 * skirt_tol, box_corner_r + skirt_tol);

        // 3. Three-Sided Stabilizer Track (open at front Y < 0, 0.140" deep on left/right/back)
        translate([-slot_w/2, -outer_d/2 - 0.01, slot_bot_z])
            cube([slot_w, slot_d + 0.01, slot_h]);

        // 3b. Front Entry Lead-In Chamfer (guides aluminum sheet smoothly into tight groove)
        translate([0, -outer_d/2, slot_bot_z + slot_h/2])
            rotate(a = 45, v = [1.0, 0.0, 0.0])
                cube([slot_w + 2*slot_chamfer, slot_h + slot_chamfer, slot_h + slot_chamfer], center = true);

        // 4. Through-Cavity for Preformed Sand Slug (0.015" inset from box cavity on all 4 sides)
        translate([-slug_w/2, -slug_d/2, skirt_h - 0.001])
            cube([slug_w, slug_d, slot_h + slug_h + 0.005]);
    }
}

// ============================================================================
// Optional Tamper / Pusher Plunger Module
// ============================================================================
module sand_pusher() {
    pw = slug_w - 2 * pusher_tol;
    pd = slug_d - 2 * pusher_tol;
    
    union() {
        // Tamper plate (fits cleanly inside mold cavity)
        translate([-pw/2, -pd/2, 0])
            cube([pw, pd, pusher_base_h]);
        // Top finger grip bar
        translate([-pw/3, -0.150, pusher_base_h - 0.001])
            cube([2*pw/3, 0.300, pusher_handle_h]);
    }
}

// ============================================================================
// Assembly & Export Rendering (Scaled to Millimeters)
// ============================================================================
scale([25.4, 25.4, 25.4]) {
    if (view_mode == "print") {
        sand_drop_mold();
        translate([0, box_d + 0.800, 0])
            sand_pusher();
    } 
    else if (view_mode == "mold") {
        sand_drop_mold();
    } 
    else if (view_mode == "pusher") {
        sand_pusher();
    }
}



