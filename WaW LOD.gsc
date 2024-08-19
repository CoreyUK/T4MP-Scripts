init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
        setPlayerDvars(player);
    }
}

setPlayerDvars(player)
{
    player setClientDvar("r_lodBiasRigid", "-1000");
    player setClientDvar("r_lodBiasSkinned", "-1000");
    player setClientDvar("r_dof_enable", "0");
    player setClientDvar("r_lodScaleSkinned", "1");
    player setClientDvar("r_lodScaleRigid", "1");
    player setClientDvar("r_forcelod", "0");
}

onPlayerSpawned()
{
    self endon("disconnect");
    for (;;)
    {
        self waittill("spawned_player");
        
    }
}
