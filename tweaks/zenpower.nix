{ config, pkgs, ...}:
{
    environment.systemPackages = [
        pkgs.zenpower
    ];
    boot.extraModulePackages = [ kernel.zenpower ];
    boot.blacklistedKernelModules =  [ "k10temp" ];
}