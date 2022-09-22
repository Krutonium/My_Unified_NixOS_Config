{ config, pkgs-unstable, ... }:
{
  environment.systemPackages = [
    pkgs-unstable.wineWowPackages.stable
    pkgs-unstable.winetricks
  ];
}
