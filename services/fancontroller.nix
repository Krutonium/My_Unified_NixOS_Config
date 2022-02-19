{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.BetterFanController
  ];
  systemd.services.betterfancontroller = {
    description = "Better Fan Controller";
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "/tmp/";
      User = "root";
      Restart = "always";
    };
    wantedBy = [ "basic.target" ];
    script = ''
      /run/current-system/sw/bin/BetterFanController
    '';
    enable = true;
  };
}
