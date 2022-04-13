{ config, pkgs, lib, ... }:
let
  workingdir = "/srv/Satisfactory";
  user = "gameserver";
in
{
  networking.firewall.allowedTCPPorts = [ 15777 15000 7777 ];
  networking.firewall.allowedUDPPorts = [ 15777 15000 7777 ];
  imports = [
    ../users/gameserver.nix
  ];
  systemd.services.satisfactory = {
    description = "Satisfactory Game Server";
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = workingdir;
      User = user;
      Restart = "on-failure";
      KillSignal = "SIGINT";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "networking.target" ];
    path = [ pkgs.steam-run-native pkgs.steamcmd ];
    script = ''
      rm -rd ${workingdir}/ || true
      steamcmd +force_install_dir ${workingdir}/ +login anonymous +app_update 1690800 validate +quit
      steam-run ${workingdir}/FactoryServer.sh -NOSTEAM
    '';
    enable = true;
  };
}
