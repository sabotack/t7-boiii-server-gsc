#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\hud_message_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\array_shared;
#include scripts\shared\flag_shared;
#include scripts\zm\gametypes\_hud_message;

#include scripts\shared\ai\zombie_utility;

#include scripts\zm\_zm_utility;
#include scripts\zm\_zm_perks;
#include scripts\zm\_zm_spawner;
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_powerups;

#include scripts\zm\_util;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_laststand;
#include scripts\zm\_zm_stats;
#include scripts\zm\_zm_score;

#namespace sabotack;

function autoexec __init__sytem__()
{
    system::register("sabotack", ::__init__, undefined, undefined);
}
	
function __init__()
{
	callback::on_start_gametype(::InitT7);
	callback::on_start_gametype(::InitShared);
	callback::on_start_gametype(::InitBase);
	callback::on_start_gametype(::initMain);
	callback::on_start_gametype(::initCounter);
	callback::on_connect(::onPlayerConnectMain);

	// Callbacks for enabling hitmarkers
	zm_spawner::register_zombie_damage_callback(::doHitmarker);
	zm_spawner::register_zombie_death_event_callback(::doHitmarkerDeath);
}
