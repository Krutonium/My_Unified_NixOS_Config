{ config, pkgs, pkgs-unstable, ... }:
let
  unstable = pkgs-unstable;
  kernel = pkgs.linuxPackages_latest;
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  networking.hostName = "uWebServer";
  networking.firewall.allowedTCPPorts = [ 25565 26666 ]; #Somtimes Minecraft Servers are run without being explicitly enabled for testing purposes.
  imports =
    [
      ../common.nix
      ../bootloaders/grub_bios.nix
      ../services/avahi.nix
      ../services/ssh.nix
      ../services/fail2ban.nix
      ../services/gitea.nix
      ../services/plex.nix
      ../services/samba.nix
      ../services/transmission.nix
      ../services/nginx.nix
      ../services/minecraft_server.nix
      #../services/stoneblock.nix
      #../services/satisfactory_server.nix
      #../services/project_ozone_3.nix
      ../services/nextcloud.nix
      ../users/krutonium.nix
      ../users/resin.nix
      ../users/root.nix
      ../users/gameserver.nix
      ../services/synapse.nix
      ../services/invidious.nix
    ];
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  #Headless Stuff
  hardware.nvidia.nvidiaPersistenced = true;
  boot.vesa = false;
  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;
  boot.kernelParams = [ "panic=1" "boot.panic_on_fail" ];
  systemd.enableEmergencyMode = false;
  boot.loader.grub.splashImage = null;


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
