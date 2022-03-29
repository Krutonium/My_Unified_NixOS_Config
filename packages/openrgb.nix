{ config, pkgs, lib, fetchFromGitLab, ... }:
let
  openrgb-src = fetchFromGitLab {
    owner = "CalcProgrammer1";
    repo = "openrgb";
    branch = "master";
  };
  openrgb = pkgs.openrgb.override { fetchFromGitLab = lib.const (openrgb-src); };
in
{
  environment.systemPackages = [
    openrgb
    pkgs.i2c-tools
  ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
}
