{ config, pkgs, lib, ... }:
let
  openrgb-rules = builtins.fetchurl {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
    sha256 = "1pxpal31rzncpg4iznz1pj97sp7i66aiqqyyyfs08z96sl68n28h";
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
