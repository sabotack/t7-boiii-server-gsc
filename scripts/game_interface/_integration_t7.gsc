InitT7()
{
    thread SetupT7();
}

SetupT7()
{
    level endon( "end_game" );
    waittillframeend;
    
    level waittill( level.notifyTypes.sharedFunctionsInitialized );
    level.eventBus.gamename = "T7";
    level.eventTypes.gameEnd = "end_game";
    
    // RegisterLogger( ::LogCustom ); // Insta crashes server :(
    
    level.overrideMethods[level.commonFunctions.getTotalShotsFired]      = ::GetTotalShotsFired;
    level.overrideMethods[level.commonFunctions.setDvar]                 = ::SetDvarIfUninitializedWrapper;
    level.overrideMethods[level.commonFunctions.waittillNotifyOrTimeout] = ::WaitillNotifyOrTimeoutWrapper;
    level.overrideMethods[level.commonFunctions.isBot]                   = ::IsBotWrapper;
    level.overrideMethods[level.commonFunctions.getXuid]                 = ::GetXuidWrapper;
    level.overrideMethods[level.commonFunctions.getPlayerFromClientNum]  = ::GetPlayerFromClientNumWrapper;
    level.overrideMethods[level.commonFunctions.setInboundData]          = ::SetInboundData;
    level.overrideMethods[level.commonFunctions.setOutboundData]         = ::SetOutboundData;
    
    RegisterClientCommands();
    
    level notify( level.notifyTypes.gameFunctionsInitialized );
}

RegisterClientCommands() 
{
    AddClientCommand("GiveWeapon",     true,  ::GiveWeaponImpl);
    AddClientCommand("TakeWeapons",    true,  ::TakeWeaponsImpl);
    AddClientCommand("Hide",           false, ::HideImpl);
    AddClientCommand("Alert",          true,  ::AlertImpl);
    AddClientCommand("Kill",           true,  ::KillImpl);
    AddClientCommand("SetSpectator",   true,  ::SetSpectatorImpl);
    AddClientCommand("AdjustPoints",   true,  ::AdjustPointsImpl);
    AddClientCommand("CEGO5050",       true,  ::CEGO5050);
}

GetTotalShotsFired()
{
    return 0; //ZM has no shot tracking. TODO: add tracking function for event weapon_fired
}

SetDvarIfUninitializedWrapper( dvar, value )
{
	if ( GetDvarString( dvar ) == "" )
	{
		SetDvar( dvar, value );
		return value;
	}
	
	return GetDvarString( dvar );
}

SetInboundData(location, data) {
    SetDvar(level.eventBus.inVar, data);
    return GetDvarString(level.eventBus.inVar);
}

SetOutboundData(location, data) {
    SetDvar(level.eventBus.outVar, data);
    return GetDvarString(level.eventBus.outVar);
}

WaitillNotifyOrTimeoutWrapper( msg, timer )
{
	self endon( msg );
	wait( timer );
}

LogCustom( logLevel, message ) 
{
    print("[" + loglevel + "]" + " " + message);
}

// God()
// {
//     if ( !IsDefined( self.godmode ) )
//     {
//         self.godmode = false;
//     }
    
//     if (!self.godmode )
//     {
//         self enableInvulnerability();
//         self.godmode = true;
//     }
//     else
//     {
//         self.godmode = false;
//         self disableInvulnerability();
//     }
// }

IsBotWrapper( client )
{
    return ( IsDefined ( client.pers["isBot"] ) && client.pers["isBot"] != 0 );
}

GetXuidWrapper()
{
    return self GetXUID();
}

GetPlayerFromClientNumWrapper( clientNum )
{
    return util::getPlayerFromClientNum(clientNum);
}

//////////////////////////////////
// Command Implementations
/////////////////////////////////

CEGO5050(event, data)
{
    if(!(self.score > 0)) {
        self iPrintLnBold("^1You do not have any points to gamble!");
        return;
    }

    msgBroadcast = "";
    msgPersonal = "";
    prevScore = self.score;
    decider = randomInt(100);
    loss = true;

    if(decider > 50) {
        loss = false;
    }

    if(loss) {
        self zm_score::add_to_player_score(self.score * -1);
        msgBroadcast = "5050: ^1" + self.name + " lost " + prevScore + " points!" ;
        msgPersonal = "^1You lost " + prevScore + " points!";
    }
    else {
        self zm_score::add_to_player_score(self.score);
        msgBroadcast = "5050: ^3" + self.name + " doubled their points!";
        msgPersonal = "^3You doubled your points!";
    }

    for (i = 0; i < level.players.size; i++) {
        if(level.players[i] getEntityNumber() == self getEntityNumber()) {
            self iPrintLnBold(msgPersonal);
            continue;
        }

        level.players[i] iPrintLnBold(msgBroadcast);
    }
}

AdjustPointsImpl(event, data) 
{
    points = data["points"];
    isNegative = false;

    if (int(points) < 0) {
        isNegative = true;
    }

    self zm_score::add_to_player_score(points);

    self iPrintLnBold("Your points have been adjusted");
}

GiveWeaponImpl(event, data)
{
    if (!isAlive(self))
    {
        return self.name + "^7 is not alive";
    }
    
    weapon = getWeapon(data["weaponName"]);

    #ifdef ZM
        self zm_weapons::weapon_give(weapon);
    #else
        self giveWeapon(weapon);
        self switchToWeapon(weapon);
    #endif
    self iPrintLnBold("You have been given a new weapon");
    
    return self.name + "^7 has been given ^5" + data["weaponName"]; 
}

TakeWeaponsImpl(event, data)
{
    if (!isAlive(self))
    {
        return self.name + "^7 is not alive";
    }
    
    self takeAllWeapons();
    self iPrintLnBold("All your weapons have been taken");
    
    return "Took weapons from " + self.name;
}

// TeamSwitchImpl( event, data )
// {
//     if ( !IsAlive( self ) )
//     {
//         return self + "^7 is not alive";
//     }
    
//     team = level.allies;
    
//     if ( self.team == "allies" ) 
//     {
//         team = level.axis;
//     }
    
//     self IPrintLnBold( "You are being team switched" );
//     wait( 2 );
//     self [[team]]();

//     return self.name + "^7 switched to " + self.team;
// }

// LockControlsImpl( event, data )
// {
//     if ( !IsAlive( self ) )
//     {
//         return self.name + "^7 is not alive";
//     }

//     if ( !IsDefined ( self.isControlLocked ) )
//     {
//         self.isControlLocked = false;
//     }

//     if ( !self.isControlLocked )
//     {
//         self freezeControls( true );
//         self God();
//         self Hide();

//         info = [];
//         info[ "alertType" ] = "Alert!";
//         info[ "message" ] = "You have been frozen!";
        
//         self AlertImpl( undefined, info );

//         self.isControlLocked = true;
        
//         return self.name + "\'s controls are locked";
//     }
//     else
//     {
//         self freezeControls( false );
//         self God();
//         self Show();

//         self.isControlLocked = false;

//         return self.name + "\'s controls are unlocked";
//     }
// }

// NoClipImpl( event, data )
// {
//     /*if ( !IsAlive( self ) )
//     {
//         self IPrintLnBold( "You are not alive" );
//     }
    
//     if ( !IsDefined ( self.isNoClipped ) )
//     {
//         self.isNoClipped = false;
//     }

//     if ( !self.isNoClipped )
//     {
//         self SetClientDvar( "sv_cheats", 1 );
//         self SetClientDvar( "cg_thirdperson", 1 );
//         self SetClientDvar( "sv_cheats", 0 );
        
//         self God();
//         self Noclip();
//         self Hide();
        
//         self.isNoClipped = true;
        
//         self IPrintLnBold( "NoClip enabled" );
//     }
//     else
//     {
//         self SetClientDvar( "sv_cheats", 1 );
//         self SetClientDvar( "cg_thirdperson", 1 );
//         self SetClientDvar( "sv_cheats", 0 );
        
//         self God();
//         self Noclip();
//         self Hide();
        
//         self.isNoClipped = false;
        
//         self IPrintLnBold( "NoClip disabled" );
//     }

//     self IPrintLnBold( "NoClip enabled" );*/

//     scripts\_integration_base::LogWarning( "NoClip is not supported on T5!" );

// }

HideImpl(event, data)
{
    if (!isAlive(self))
    {
        self iPrintLnBold("You are not alive");
        return;
    }
    
    if (!isDefined(self.isHidden))
    {
        self.isHidden = false;
    }

    if (!self.isHidden)
    {
        self setClientThirdPerson(1);
        self enableInvulnerability();
        self Hide();

        self.ignoreme = true;   
        self.isHidden = true;
        
        self IPrintLnBold( "Hide enabled" );
    }
    else
    {
        self setClientThirdPerson(0);
        self disableInvulnerability();
        self Show();
        
        self.ignoreme = false;
        self.isHidden = false;
        
        self IPrintLnBold( "Hide disabled" );
    }
}

AlertImpl(event, data)
{
    self iPrintLnBold(data["message"]);

    return "Sent alert to " + self.name; 
}

// GotoImpl( event, data )
// {
//     if ( IsDefined( event.target ) )
//     {
//         return self GotoPlayerImpl( event.target );
//     }
//     else
//     {
//         return self GotoCoordImpl( data );
//     }
// }

// GotoCoordImpl( data )
// {
//     if ( !IsAlive( self ) )
//     {
//         self IPrintLnBold( "You are not alive" );
//         return;
//     }

//     position = ( int( data["x"] ), int( data["y"] ), int( data["z"]) );
//     self SetOrigin( position );
//     self IPrintLnBold( "Moved to " + "("+ position[0] + "," + position[1] + "," + position[2] + ")" );
// }

// GotoPlayerImpl( target )
// {
//     if ( !IsAlive( target ) )
//     {
//         self IPrintLnBold( target.name + " is not alive" );
//         return;
//     }

//     self SetOrigin( target GetOrigin() );
//     self IPrintLnBold( "Moved to " + target.name );
// }

// PlayerToMeImpl( event, data )
// {
//     if ( !IsAlive( self ) )
//     {
//         return self.name + " is not alive";
//     }

//     self SetOrigin( event.origin GetOrigin() );
//     return "Moved here " + self.name;    
// }

KillImpl(event, data)
{
    if (self.sessionstate != "playing")
    {
        return self.name + " is not alive";
    }

    #ifdef ZM
    self notify("player_suicide");
    util::wait_network_frame(); //to guarantee the notify gets sent and processed before the rest of this script continues to turn the guy into a spectator
    
    //Stat Tracking
    self zm_stats::increment_client_stat( "suicides" );
    self zm_laststand::bleed_out();
    #else
    self suicide();
    #endif
    
    self iPrintLnBold("You were killed by " + self.name);

    return "You killed " + self.name;
}

SetSpectatorImpl(event, data)
{
    if (self.pers["team"] == "spectator") 
    {
        return self.name + " is already spectating";
    }
    
    self [[level.spectator]]();
    self iPrintLnBold("You have been moved to spectator");
    
    return self.name + " has been moved to spectator";
}
