{ config, pkgs, ... }:
let
  kernel = config.boot.kernelPackages;
in
{
  environment.systemPackages = [
    kernel.zenpower
  ];
  boot.extraModulePackages = [ kernel.zenpower ];
  boot.blacklistedKernelModules = [ "k10temp" ];
}
