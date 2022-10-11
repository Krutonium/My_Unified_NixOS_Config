{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wine
    pkgs.wine64
    pkgs.winePackages.stable
    pkgs.wineWowPackages.stable
    pkgs.winetricks
  ];
}
