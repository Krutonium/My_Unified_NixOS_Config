{ config, pkgs, ...}:
{
    environment.systemPackages = [
        pkgs.qmk
        pkgs.qmk-udev-rules
        pkgs.arduino pkgs.gcc11
        pkgs.pkgsCross.avr.buildPackages.gcc
        pkgs.avrdude
        pkgs.gcc-arm-embedded
        pkgs.gnumake
    ];
}