{ config, pkgs, lib, ...}:
let
  unstable = pkgs-unstable;
  openrgb-rules = builtins.fetchurl {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
  };
in
{
  environment.systemPackages = [
    pkgs.i2c-tools
    unstable.openrgb
  ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  services.udev.extraRules = openrgb-rules;
}