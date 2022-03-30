{ config, pkgs, ... }:
#This is the configuration specific to my Gaming Desktop PC.

#Run sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
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
    #../desktops/kde.nix
    ../services/drwhowifi.nix
    ../tweaks/VL805.nix
    ../tweaks/mitigations.nix
    ../tweaks/zfs.nix
    ../tweaks/zenpower.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/KeyboardStuff/openrgb.nix
    #../packages/KeyboardStuff/qmk.nix
    ../packages/KeyboardStuff/flasher.nix
    ../packages/virtual_machines.nix
    ../packages/candy-icons.nix
    ../tweaks/nvidia_nodriver.nix
  ];
   # We always want 8 GB of Swap.
   swapDevices = [{
     device = "/swap";
     size = 1024 * 1; #1GB
   }];
  #Set Hostname
  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  networking.hostName = Hostname;
  hardware.enableAllFirmware = true;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  system.stateVersion = "21.11";
}
