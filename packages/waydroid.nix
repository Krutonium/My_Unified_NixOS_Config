{ config, pkgs, ... }:
{
    virtualisation.waydroid.enable = true;
        environment.systemPackages = [
        pkgs.waydroid
   ];
}
