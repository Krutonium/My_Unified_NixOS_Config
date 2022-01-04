{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.wineWowPackages.stable
	pkgs.winetricks
   ];
}
