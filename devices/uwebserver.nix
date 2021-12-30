{ config, pkgs, ...}:
let
    nixpkgs-unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
    {config = config.nixpkgs.config;};
in
{
    imports =
    [
        ./hardware-configuration.nix
        ../bootloaders/grub.nix
        ../services/ahavi.nix
        ../services/ssh.nix
        ../services/fail2ban.nix
        ../services/gitea.nix
        ../services/plex.nix
        ../services/samba.nix
        ../services/satisfactory_server.nix
        ../services/transmssion.nix
        ../services/nginx.nix
        ../users/krutonium.nix
        ../users/resin.nix
    ];
    nixpkgs.config.allowUnfree = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = with pkgs; [
         wget
         nano
         htop
         neofetch
         git
         screen
         steamcmd
         nixpkgs-unstable.plex
    ];
    system.stateVersion = "21.11";
}
