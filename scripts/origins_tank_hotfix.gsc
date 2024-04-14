function hotfixTombEE() {
    moveLightningStaffParts();
    level flag::wait_till("initial_blackscreen_passed");
    disableTombTank();
}

function moveLightningStaffParts() {
    staff_parts = struct::get_array("elemental_staff_lightning_lower_staff", "targetname");

    for(i=0;i<staff_parts.size;i++) {
        staff_parts[i].origin = (288, -2687, 310) + (0,0,35);
    }

    staff_parts = struct::get_array("elemental_staff_lightning_middle_staff", "targetname");
    
    for(i=0;i<staff_parts.size;i++) {
        staff_parts[i].origin = (-1025, 433, 102.875) + (0,0,35);
    }

    staff_parts = struct::get_array("elemental_staff_lightning_upper_staff", "targetname");
    
    for(i=0;i<staff_parts.size;i++) {
        staff_parts[i].origin = (1210, 3333, -150.875) + (0,0,35);
    }
}

function disableTombTank() {
    t_use = getEnt("trig_use_tank", "targetname");

    warning = spawn("trigger_box", t_use.origin, 0, 100, 450, 200);
    warning setHintString("Tank is disabled due crashing issue, lightning staff parts are available without it");
    warning setCursorHint("HINT_NOICON");

    t_use delete();
}
