{ config, pkgs, ...}:
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
        ../services/fancontroller.nix
        ../services/ssh.nix
        ../desktops/gnome.nix
        ../services/drwhowifi.nix
        ../tweaks/VL805.nix
        ../tweaks/mitigations.nix
        ../tweaks/zfs.nix
        ../packages/dotnet.nix
        ../packages/steam.nix
        ../packages/qmk.nix
	../packages/wine.nix
        <nixos-hardware/common/pc>
        <nixos-hardware/common/pc/ssd>
        <nixos-hardware/common/cpu/amd>
        <nixos-hardware/common/gpu/amd>
    ];
    nixpkgs.localSystem = {
        gcc.arch = "znver1";
        gcc.tune = "znver1";
        system = "x86_64-linux";
    };
    nix.systemFeatures = [ "gccarch-znver1" ];
    #Set Hostname
    networking.hostName = Hostname;
    home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
    boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
    system.stateVersion = "21.11";
}
