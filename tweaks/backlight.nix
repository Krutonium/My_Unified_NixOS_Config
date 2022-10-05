{ config, pkgs, ... }:
let
  kernel = config.boot.kernelPackages;
in
{
  #Enables backlight control for desktops
  environment.systemPackages = [
    kernel.ddcci-driver
  ];
  boot.extraModulePackages = [ kernel.ddcci-driver ];
}
