{ config, pkgs, ...}:
let
    kernel = pkgs.linuxPackages_zen;	
in
{
    environment.systemPackages = [
        pkgs.zenpower
    ];
    boot.extraModulePackages = [ kernel.zenpower ];
    boot.blacklistedKernelModules =  [ "k10temp" ];
}
