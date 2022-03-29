{ config, pkgs, lib, ... }:
let
  openrgb-src = fetchFromGitLab {
    owner = "openrgb";
    repo = "openrgb";
    branch = "master";
    rev = "master";
  };
  openrgb = pkgs.openrgb.override { fetchFromGitLab = lib.const (openrgb-src); };
in
{
  environment.systemPackages = [
    openrgb
    pkgs.i2c-tools
  ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  services.udev.extraRules = openrgb-rules;
}
