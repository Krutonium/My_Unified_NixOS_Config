{ config, pkgs, ...}:
let
  kernel = config.boot.kernelPackages;
in
{
  environment.systemPackages = [
    kernel.nvidia_x11_beta
  ];
  boot.extraModulePackages = [ kernel.nvidia_x11_beta ];
  boot.blacklistedKernelModules = [ "nouveau" ];
}