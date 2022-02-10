{ config, pkgs, lib, ... }:
let
  workingdir = "/srv/StoneBlock";
  user = "gameserver";
in
{
  networking.firewall.allowedTCPPorts = [ 25565 ];
  systemd.services.stoneblock = {
    description = "Stoneblock Game Server";
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = workingdir;
      User = user;
      Restart = "on-failure";
      KillSignal = "SIGINT";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "networking.target" ];
    path = [ pkgs.openjdk8 pkgs.steam-run-native pkgs.screen ];
    script = ''
      steam-run screen -DmS stoneblock ${workingdir}/LaunchServer.sh
    '';
    enable = false;
  };
}
