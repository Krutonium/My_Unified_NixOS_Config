{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.BetterFanController
  ];
  systemd.services.betterfancontroller.enable = true;
}
