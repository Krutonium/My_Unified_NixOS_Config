{ lib, config, pkgs, pkgs-unstable, ... }:
let
  kernel = pkgs.linuxPackages_zen;
  Hostname = "uIsoDevice";
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  imports = [
    ../users/krutonium.nix
    ../users/root.nix
    ../services/ssh.nix
    ../tweaks/mitigations.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/candy-icons.nix
  ];
  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  home-manager.users.root = import ../home-manager-files/root/root.nix;
  networking.hostName = Hostname;
}
