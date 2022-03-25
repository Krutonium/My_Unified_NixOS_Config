{ config, pkgs, lib, ... }:
let
  openrgb-rules = builtins.fetchurl {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
    sha256 = "0lbh1ccr5b9jz835xhic93vw37mmm1bdxsk8vjjp9winvj7dmspn";
  };
in
{
  environment.systemPackages = [
    pkgs.i2c-tools
    pkgs.openrgb
  ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  services.udev.extraRules = openrgb-rules;
}
