#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{    
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for( ;; )
    {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon( "disconnect" );

    for( ;; )
    {
        self waittill( "spawned_player" );
        self takeWeapon( "tabun_gas_mp" );
        self takeWeapon( "signal_flare_mp" );
        self giveWeapon( "m8_white_smoke_mp" );
        
    }
}
