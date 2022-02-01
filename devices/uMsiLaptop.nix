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
	../users/root.nix
        ../services/ssh.nix
        ../services/fail2ban.nix
        ../desktops/gnome.nix
        ../tweaks/mitigations.nix
        ../packages/dotnet.nix
        ../packages/steam.nix
        ../packages/wine.nix
        ../packages/ccache.nix
        ../packages/waydroid.nix
    ];
    home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
    networking.hostName = Hostname;
}