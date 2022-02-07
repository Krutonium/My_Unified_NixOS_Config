{ config, pkgs, ... }:
#This is the configuration specific to my Gaming Desktop PC.

#Run sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
let
  kernel = pkgs.linuxPackages_zen;
  Hostname = "uGamingPC";
in
{
  imports = [
    ../bootloaders/grub.nix
    ../users/krutonium.nix
    ../users/root.nix
    ../users/notkea.nix
    ../services/fancontroller.nix
    ../services/ssh.nix
    ../desktops/gnome.nix
    ../services/drwhowifi.nix
    ../tweaks/VL805.nix
    ../tweaks/mitigations.nix
    ../tweaks/zfs.nix
    ../tweaks/zenpower.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/qmk.nix
    ../packages/wine.nix
  ];

  nix.systemFeatures = [ "gccarch-znver1" "big-parallel" ];
  #Set Hostname
  networking.hostName = Hostname;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  system.stateVersion = "21.11";
}
