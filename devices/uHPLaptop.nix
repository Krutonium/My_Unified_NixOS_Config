{ config, pkgs, ... }:
let
  Hostname = "uHPLaptop";
  kernel = pkgs.linuxPackages_zen;
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  imports = [
    ../bootloaders/grub_bios.nix
    ../users/krutonium.nix
    ../users/root.nix
    ../services/ssh.nix
    ../services/fail2ban.nix
    ../services/fprintd.nix
    ../desktops/gnome.nix
    ../tweaks/mitigations.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
  ];
  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  networking.hostName = Hostname;
  # One could argue this should be a tweak, but honestly it's very hardware specific.
  boot.kernelParams = [ "acpi_backlight=native" ];
  sound.extraConfig = ''
    options snd-hda-intel model=hp-dv5
  '';
  sound.enable = true;
}
