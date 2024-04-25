function initMain() {
    level.clientid = 0;
    level.perk_purchase_limit = 9;
   
    // Origins tank crash hotfix
    thread sabotack::hotfixTombEE();
}

function onPlayerConnectMain() {
    self.clientid = matchRecordNewPlayer(self);

	if(!isdefined(self.clientid) || self.clientid == -1)
	{
		self.clientid = level.clientid;
		level.clientid++;
	}

    self waittill("spawned_player");
    self thread onPlayerSpawnedMain();
}

function onPlayerSpawnedMain() {
    self endon("disconnect");

    // Remove perk limit
    wait (12);
    self iPrintLnBold("^1Your perk limit has been removed!");
}




