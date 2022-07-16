{ config, pkgs, lib, ... }:
let
  workingdir = "/home/krutonium/create";
  user = "krutonium";
in
{
  networking.firewall.allowedTCPPorts = [ 25565 ];
  systemd.services.create = {
    description = "Create Game Server";
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = workingdir;
      User = user;
      Restart = "always";
      KillSignal = "SIGINT";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "networking.target" ];
    path = [ pkgs.openjdk17 pkgs.steam-run-native pkgs.screen ];
    script = ''
      cd ${workingdir}
      # steam-run screen -DmS ozone ${workingdir}/run.sh
      ./run.sh
    '';
    enable = true;
  };
}
