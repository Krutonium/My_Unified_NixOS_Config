{ config, pkgs, ...}:
let
    unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
    {config = config.nixpkgs.config;};
in
{
    networking.hostName = "uWebServer";
    imports =
    [
        ../hardware-configuration.nix
        ../bootloaders/grub_bios.nix
        ../services/ahavi.nix
        ../services/ssh.nix
        ../services/fail2ban.nix
        ../services/gitea.nix
        ../services/plex.nix
        ../services/samba.nix
        #../services/satisfactory_server.nix
        ../services/transmission.nix
        ../services/nginx.nix
        #../services/minecraft_server.nix
        ../services/nextcloud.nix
        ../users/krutonium.nix
        ../users/resin.nix
    ];
    nixpkgs.config.allowUnfree = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = [
         pkgs.wget
         pkgs.nano
         pkgs.htop
         pkgs.neofetch
         pkgs.git
         pkgs.screen
         pkgs.steamcmd
         unstable.plex
    ];
    system.stateVersion = "21.11";
}
