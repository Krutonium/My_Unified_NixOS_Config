{ config, pkgs, lib, ... }:
let
  workingdir = "/home/krutonium/CuboidOutpost/";
  user = "krutonium";
in
{
  networking.firewall.allowedTCPPorts = [ 25565 ];
  systemd.services.po3 = {
    description = "CuboidOutpost Game Server";
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
      steam-run screen -DmS cuboid ${workingdir}/ServerStart.sh
    '';
    enable = true;
  };
}
