{ config, pkgs-unstable, pkgs, lib, fetchzip, ... }:
let
  openrgb-src = pkgs.fetchFromGitLab {
    owner = "CalcProgrammer1";
    repo = "OpenRGB";
    rev = "04c1ad363e4da9677de431e23792b2e38a1d3c95";
    sha256 = "sha256-JPpFkpiqeh2unOGdjUSfgr/q/uC+fFDy2f6PetIHQFQ=";
  };

  openrgb = pkgs-unstable.openrgb.override { fetchFromGitLab = lib.const (openrgb-src); };
in
{
  environment.systemPackages = [
    openrgb
    pkgs.i2c-tools
  ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
}
