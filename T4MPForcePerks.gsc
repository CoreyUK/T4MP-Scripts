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
        self waittill( "give_map" );
        self checkIfValidPerks();  
    }
}

checkIfValidPerks()
{
    perks = maps\mp\gametypes\_globallogic::getPerks( self );
    for( i = 0; i < perks.size; i++ )
    {
        if( blockedPerks( perks[i] ) )
        {
            replacePerks( i, perks[i] );
        }
    }
}

blockedPerks( perk )
{
    switch( perk )
    {
        case "specialty_armorvest":
        case "specialty_pistoldeath":
        case "specialty_weapon_flamethrower":
        case "specialty_grenadepulldeath":
        case "specialty_weapon_bouncing_betty":
            return true;
        default:
            return false;
    }
}

replacePerks( index, perk ) 
{
    self unSetPerk( perk );
    switch( index )
    {
        case 0:
            self setPerk( "specialty_extraammo" );
            break;
        case 1:
            self setPerk( "specialty_bulletdamage" );
            break;
        case 2:
            self setPerk( "specialty_bulletpenetration" );
            break;
        case 3:
            self setPerk( "specialty_water_cooled" );
            break;
        default:
            break;
    }
}
