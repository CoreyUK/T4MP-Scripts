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

    // Replace Banned Weapons
    weaponList = self getWeaponsList();
    for ( i = 0; i < weaponList.size; i++ ) 
    {
        weaponNameShort = strtok( weaponList[i], "_" )[0];
        if ( blockedWeapons( weaponNameShort ) )
        {        
            self takeWeapon( weaponList[i] );
            self giveWeapon( "springfield_scoped_mp" );
            wait (0.2);
            self switchToWeapon( "springfield_scoped_mp" );
        }
    }

    // Replace Banned Perks
    perks = maps\mp\gametypes\_globallogic::getPerks( self );
    for( i = 0; i < perks.size; i++ )
    {
        if( blockedPerks( perks[i] ) )
        {
            replacePerks( i, perks[i] );
        }
    }
}

blockedWeapons( weapon )
{
	//self iPrintLnBold( weapon );
    switch( weapon )
    {
        case "type100smg":
        case "thompson":
        case "mp40":
        case "stg44":
        case "sten":
        case "mg42":
        case "type99":
        case "bar":
        case "fg42":
        case "bren":
        case "type99_lmg":
        case "ppsh":
        case "30cal":
        case "dp28":
        case "svt40":
        case "m1carbine":
        case "gewehr43":
        case "doublebarrel":
        case "shotgun":
        case "doublebarreledshotgun":
        case "m1garand":
    
            return true;
        default:
            return false;
    }
    return false;
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

blockedPerks( perk )
{
    switch( perk )
    {
        case "specialty_armorvest":
        case "specialty_pistoldeath":
        case "specialty_weapon_bazooka":
        case "specialty_weapon_flamethrower":
        case "specialty_grenadepulldeath":
        case "specialty_weapon_satchel_charge":
        case "specialty_weapon_bouncing_betty":
            return true;
        default:
            return false;
    }
    return false;
}
