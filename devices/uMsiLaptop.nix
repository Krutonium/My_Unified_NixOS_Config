{ config, pkgs, ... }:
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
    ../tweaks/mitigations.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/ccache.nix
    ../packages/waydroid.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/candy-icons.nix
  ];
  swapDevices = [{
    device = "/swap";
    size = 1024 * 16; #16GB
  }];
  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  networking.hostName = Hostname;
}
