{ config, ...}:
{
    users.users.gameserver = {
        isSystemUser = true;
        extraGroups = [ ];
	group = "gameserver";
    };
}
