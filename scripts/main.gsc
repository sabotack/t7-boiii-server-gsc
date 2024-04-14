function initMain() {
    level.clientid = 0;
   
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
}

function onPlayerSpawnedMain() {
    // Remove perk limit
    wait (12);
    // self enableInvulnerability(); // Testing
    level.perk_purchase_limit = 9;
    self iPrintLnBold("^1Your perk limit has been removed!");
    wait 2;
    
    // Testing
    // wait (2);
    // self iPrintLnBold("^3Given speed cola!");
    // self doGivePerk("specialty_fastreload");

    // self zm_score::add_to_player_score(100000);
    // self iPrintLnBold("Adjusted points by ^2100000");
}




