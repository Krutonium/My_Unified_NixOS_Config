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
#        <nixos-hardware/common/gpu/nvidia> #This doesn't work for some reason
    ];
    home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
    nixpkgs.localSystem = {
        gcc.arch = "haswell";
        gcc.tune = "haswell";
        system = "x86_64-linux";
    };
    nix.extraOptions = ''
    extra-sandbox-paths = /nix/var/cache/ccache
    '';
    nix.systemFeatures = [ "gccarch-haswell" ];
    networking.hostName = Hostname;
}
