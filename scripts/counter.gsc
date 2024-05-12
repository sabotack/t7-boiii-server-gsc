function initCounter() {
    thread zombieCounter();
}


function zombieCounter()
{
    level endon("end_game");
	level flag::wait_till("initial_blackscreen_passed");
	hud = counterHud("^4Zombies Left:");
	while(1)
	{
		total = level.zombie_total + zombie_utility::get_current_zombie_count();

        if(level flag::get("dog_round"))
            hud setText("^4Dogs Left: ^2" + total);
        else
            hud setText("^4Zombies Left: ^2" + total);
		
        wait(0.1);
	}
}

function counterHud(text)
{
	hud = NewHudElem();
	hud.horzAlign = "center";
	hud.vertAlign = "top";
	hud.alignX = "center";
	hud.alignY = "top";
	hud.y = 10;
	hud.foreground = 1;
	hud.fontscale = 1.5;
	hud.alpha = 1;
	hud setText(text);
	return hud;
}