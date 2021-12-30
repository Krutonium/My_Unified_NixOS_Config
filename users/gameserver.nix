{ config, ...}:
{
    users.users.gameserver = {
        isNormalUser = false;
        extraGroups = [ ];
    };
}
