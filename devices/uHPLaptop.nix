{ config, pkgs, ... }:
let
    Hostname = "uHPLaptop";
in
{
    imports = [
        ../bootloaders/grub_bios.nix
        ../users/krutonium.nix
        ../services/ssh.nix
        ../services/fail2ban.nix
        ../desktops/gnome.nix
        ../tweaks/mitigations.nix
        ../packages/dotnet.nix
        ../packages/home-manager.nix
        ../packages/steam.nix
	    ../packages/wine.nix
	    ../packages/ccache.nix
        <nixos-hardware/common/pc>
        <nixos-hardware/common/pc/ssd>
        <nixos-hardware/common/cpu/intel>
    ];
    home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
    networking.hostName = Hostname;
}