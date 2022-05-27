{ lib, config, pkgs, pkgs-unstable, ... }:
let
  kernel = pkgs.linuxPackages_zen;
  Hostname = "uMsiLaptop";
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  imports = [
    ../bootloaders/systemd.nix
    ../users/krutonium.nix
    ../users/root.nix
    ../services/ssh.nix
    ../services/fail2ban.nix
    ../desktops/gnome.nix
    #../desktops/xfce.nix
    ../tweaks/mitigations.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/ccache.nix
    ../packages/waydroid.nix
    #../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/candy-icons.nix
    ../packages/virtual_machines.nix
  ];
  swapDevices = [{
    device = "/swap";
    size = 1024 * 16; #16GB
  }];
  #nix.settings.system-features = [ "gccarch-haswell" ];  
  #nixpkgs.localSystem = {
  #  gcc.arch = "haswell";
  #  gcc.tune = "haswell";
  #  system = "x86_64-linux";
  #};

  #services.onedrive.enable = true;
  hardware.bumblebee.enable = true;
  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  home-manager.users.root = import ../home-manager-files/root/root.nix;
  networking.hostName = Hostname;
}
