{ config, ...}:
{
    users.users.gameserver = {
        isNormalUser = true;
        extraGroups = [ ];
    };
}
