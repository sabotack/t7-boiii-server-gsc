// Internal function for handling hitmarkers
function doHitmarkerInternal(str_mod, death) {
    if(!isPlayer(self)) {
        return;
    }

    if(!isdefined(death)) {
        death = false;
    }

    if(isdefined(str_mod) && str_mod != "MOD_CRUSH" && str_mod != "MOD_HIT_BY_OBJECT") {
        self.hud_damagefeedback.color = (1, 1, 1);
    
        if (death) {
            self.hud_damagefeedback.color = (1, 0, 0);
        }

        self.hud_damagefeedback setShader("damage_feedback", 24, 48 );
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeOverTime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// White hitmarker callback on zombie damage
function doHitmarker(str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, direction_vec, tagName, modelName, partName, dFlags, inflictor, chargeLevel) {
    if(isDefined(e_player) && isPlayer(e_player) && e_player != self) {
        self thread zm_powerups::check_for_instakill(e_player, str_mod, str_hit_location);

        e_player thread doHitmarkerInternal(str_mod);

        // Check if player should have points
        if(!self.no_damage_points && isDefined(e_player)) {
            damage_type = "damage";
            e_player zm_score::player_add_points(damage_type, str_mod, str_hit_location, false, undefined, w_weapon);
        }
    }
}

// Red hitmarker callback on zombie death
function doHitmarkerDeath() {
    if(isdefined(self.attacker) && isplayer(self.attacker) && self.attacker != self) {
        self.attacker thread doHitmarkerInternal(self.damagemod, true);
    }
}