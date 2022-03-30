#NOTICE: This doesn't actually work. It complains about not being able to access .//quantum/version.h

{ config, pkgs, ... }:
let
  #Build redragon:k582 firmware
  firmware-src = pkgs.fetchFromGitHub  {
    fetchSubmodules = true;
    owner = "SonixQMK";
    repo = "qmk_firmware";
    rev = "a2a29b002315c3d69f8640fc74eb799902968b1f";
    sha256 = "sha256-RzsklZEhwe/xbffl4mUlDx0hyoumwtxRWMdM1rGI+cY=";
    deepClone = true;
    forceFetchGit = true;
  };

  k582-fw = pkgs.stdenv.mkDerivation {
    name = "k582-firmware";
    buildInputs = [
      pkgs.unzip
      pkgs.qmk
      pkgs.qmk-udev-rules
      pkgs.arduino
      pkgs.gcc11
      pkgs.pkgsCross.avr.buildPackages.gcc
      pkgs.avrdude
      pkgs.gcc-arm-embedded
      pkgs.gnumake
      pkgs.git
      pkgs.python39Full
    ];
    src = firmware-src;
    buildCommand = ''
      cd $src
      make redragon/k582:default
      mkdir -p $out/usr/bin/firmware/
      cp redragon_k582_default.bin $out/usr/bin/firmware/
    '';
  };

in
{
  environment.systemPackages = [
    k582-fw
  ];
}
