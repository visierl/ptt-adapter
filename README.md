# PTT and Keying Adapter Enclosure

## Overview

This project is a 3D printed PTT and Keying interface adaptor
enclosure to be used with Quisk. It is designed to work with a specific

```
FT232RL FTDI USB Type C Serial Adapter
```

found on Amazon and will need to be adapted for other adaptors. The
front panel supports two 1/4" mono phone jacks, one for the Key the
other for the PTT switch (plugged in separately). The back panel
provides a cutout for the USB-C port on the adpater card.

## Electrical Connections

Both the Key and PTT jacks should be mono unswitched 1/4" headphone
jacks. The tip connection on the Key jack should go to the DSR
connection on the serial card. The tip of the PTT jack should go to
the CTS connection. The rings on both jacks should go to Ground
(GND). It would not hurt to pull the CTS and DSR connections high with
a 4.7K resistor to a 5V VCC on he serial adaptor to keep them from
switching if they get RF in them. Also bypassing these same signals
with 0.01uFd capacitors to ground will help shunt RF away.

The small hole on the front panel is for a switch to switch the Key
jack between Key / Keyer mode (i.e. a single on-off externally timed)
and Paddles (separate dit and dah inputs to let Quisk do its own
keying). Wire the ring of the TRS Key jack so that when the switch is
in the Paddles direction, the DSR (PTT signal) is connected to the
ring and when the switch is in Key / Keyer position the ring has no
connection. Then a set of paddles can be wired with 'dit' going to the
tip and 'dah' going to the ring.

## Printing Instructions

These printing instructions are specifically tailored to using Orca
Slicer to prepare a PLA enclosure for printing and an Elegoo Centauri
Carbon printer for printing. They will need to be adapted for use with
other slicers and printers.

NOTE: the enclosure has a cavity for a small amount of Kinetic Sand balast to give some weight to the final product. The instructions explain how to pause printing and add the sand at the appropriate point.

**Printer:** Elegoo Centauri Carbon  
**Slicer:** OrcaSlicer  
**Filament:** PLA  
**Ballast:** Kinetic Sand  

---

### 1. Exporting STLs from OpenSCAD
1. Open the `.scad` file in OpenSCAD.
2. Set `view_mode` at the top of the script:
   - Use `"print"` to export both the box and upside-down lid together on one build plate.
   - Or export separately using `"box"` and `"lid"`.
3. Press **F6** (*Design → Render*) and wait for the full mesh compilation to finish.
4. Click **File → Export → Export as STL**.  
   *(Note: The script automatically scales inches to millimeters via `scale([25.4, 25.4, 25.4])`.)*

---

### 2. OrcaSlicer Process Settings
Enable the **Advanced** toggle at the top of the **Process** tab and configure the following:

### Quality & Strength
* **Layer Height:** `0.20 mm`
* **Supports:** **Disabled (Off)** — both parts print flat without supports.
* **Wall Loops:** `3`
* **Top Shell Layers:** `6` *(ensures a rigid 1 bridge + 5 solid layer ceiling above the sand)*
* **Infill:** Set a **Height Range Modifier** from `2.00 mm` to `8.40 mm` with **Sparse Infill Density = `0%`** so the sand cavity stays completely hollow.

#### Bridging (for the `56 mm` Sand Cavity Span)
* **Thick Bridges** (*Quality → Bridge*): **Unchecked**
* **Bridge Flow** (*Quality → Bridge*): `0.90` – `0.95` *(pulls the strand taut so it does not sag)*
* **Bridge Speed** (*Speed → Other layers speed*): `45` – `50 mm/s`
* **Bridge Direction** (*Strength → Top/bottom*): Set to `90°` (or `0°`) so the light-blue bridge lines span across the shorter **front-to-back (`2.20"`)** distance rather than left-to-right. Verify in the **Line Type** preview.

---

### 3. PLA Cooling & Enclosure Setup
In **Filament Settings → Cooling**:
* **Force cooling for overhangs and bridges:** **Enabled (Checked)**
* **Cooling overhang threshold:** `10%`
* **Auxiliary Part Cooling Fan:** `70%` – `100%`
* **Printer Chamber:** Remove the top glass lid or leave the front door cracked open to prevent heat creep when printing PLA.

---

### 4. Setting the Sand-Fill Pause in OrcaSlicer
1. Click **Slice plate**.
2. In the **Preview** tab, drag the right-hand vertical layer slider to **`8.40 mm`** (Layer `42` at `0.20 mm` layer height).
3. Verify visually that `8.40 mm` is the **first layer drawing light-blue bridge lines** across the open cavity.
4. **Right-click the `+` icon** on the slider at `8.40 mm` and select **Add Pause**.
5. Click **Slice plate** again to bake the pause command into the G-code.

---

### 5. Kinetic Sand Packing Checklist (During Pause)
1. Firmly pack kinetic sand into the cavity, leaving the top surface **`0.5 mm` to `1.0 mm` below** the top plastic rim so the nozzle never grazes the sand while bridging.
2. Thoroughly wipe the top perimeter of the plastic walls with a **dry cotton swab or paper towel** to remove any silicone oil residue from the kinetic sand (oil on the rim will prevent the `8.40 mm` bridge layer from bonding).
3. Press **Resume** on the touchscreen.

---

### 6. Post-Print Hardware & Assembly
* **Lid Fasteners:**
  * Set 4 Ruthex RX-4-40x5.7 heat set threaded inserts into the corner bosses to accept the cover screws
  * Attach the cover with 4× 4-40 flat-head screws 
* **Circuit Board:**
  * Slide the rear edge of the `0.062"` PCB into the slot in the back wall so the USB-C receptacle seats flush into the cutout,
  * rest the front edge onto the two front riser posts (it should fit snuggly and flat within the riser box)
  * Spot melt (using a small soldering iron tip) near the back of the PCB along the left and right rails of the riser to secure the PCB once all connections are made.
* **Feet:** Press 4× **`0.400"` (`10 mm`)** self-adhesive clear silicone feet into the circular detents on the bottom.
