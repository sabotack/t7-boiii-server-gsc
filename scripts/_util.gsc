function doGivePerk(perk) {
    if (!(self hasPerk(perk) || self zm_perks::has_perk_paused(perk))) {
        self zm_perks::vending_trigger_post_think( self, perk );
    }
    else {
        self notify(perk + "_stop");
        self iPrintLn("Perk [" + perk + "] ^1Removed");
    }
}
