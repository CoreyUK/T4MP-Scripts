#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{    
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");

    for(;;)
    {
        self waittill( "spawned_player" );
        self checkIfValidWeapons();  
    }
}

checkIfValidWeapons()
{
    // Replace Secondaries
    self takeWeapon( "tabun_gas_mp" );
    self takeWeapon( "signal_flare_mp" );
    self giveWeapon( "m8_white_smoke_mp" );
    
    // Replace Non-Scoped Rifles
    weaponList = self getWeaponsListPrimaries();
    for ( i = 0; i < weaponList.size; i++ ) 
    {
        weaponNameShort = strtok( weaponList[i], "_" )[0];

        if ( !checkIfAllowed( weaponNameShort ) )
        {        
            self takeWeapon( weaponList[i] );
            self giveWeapon( "springfield_scoped_mp" );
            wait (0.2);
            self switchToWeapon( "springfield_scoped_mp" );
        }
    }
}

checkIfAllowed( weapon )
{
    switch( weapon )
    {
        case "springfield":
        case "mosin":
        case "kar98k":
        case "lee_enfield":
        case "ptrs41":
            return true;
        default:
            return false;
    }
    return false;
}
