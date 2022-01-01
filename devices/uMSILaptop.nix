{ config, pkgs, ...}:
#This is the configuration specific to my Gaming Desktop PC.

#Run sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
let
    kernel = pkgs.linuxPackages_zen;
    Hostname = "uMsiLaptop";
in
{
    imports = [
        ../bootloaders/systemd.nix
        ../users/krutonium.nix
        ../services/ssh.nix
        ../serivces/fail2ban.nix
        ../desktops/gnome.nix
        ../tweaks/mitigations.nix
        ../packages/dotnet.nix
        ../packages/home-manager.nix
        ../packages/steam.nix
        <nixos-hardware/common/pc>
        <nixos-hardware/common/pc/ssd>
        <nixos-hardware/common/cpu/intel>
        <nixos-hardware/common/gpu/nvidia>
    ];
    networking.hostName = Hostname;
}