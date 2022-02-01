{ config, ... }:
# This user is not intended to be added directly, only by services that run game servers.
{
  users.users.gameserver = {
    isNormalUser = true;
    extraGroups = [ ];
  };
}
