{ config, pkgs, ... }:
let
  kernel = pkgs.linuxPackages_zen;
  Hostname = "uGamingPC";
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  imports = [
    ../bootloaders/grub.nix
    ../users/krutonium.nix
    ../users/root.nix
    ../users/notkea.nix
    ../services/fancontroller.nix
    ../services/ssh.nix
    ../desktops/gnome.nix
    ../tweaks/mitigations.nix
    ../tweaks/zenpower.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/KeyboardStuff/openrgb.nix
    ../packages/KeyboardStuff/flasher.nix
    ../packages/virtual_machines.nix
    ../packages/candy-icons.nix
    ../packages/compiler.nix
  ];
  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  home-manager.users.root = import ../home-manager-files/root/root.nix;
  networking.hostName = Hostname;
  hardware.enableAllFirmware = true;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  system.stateVersion = "21.11";
}
