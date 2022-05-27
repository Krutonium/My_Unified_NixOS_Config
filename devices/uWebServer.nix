{ config, pkgs, pkgs-unstable, ... }:
let
  unstable = pkgs-unstable;
  kernel = pkgs.linuxPackages;
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  networking.hostName = "uWebServer";
  networking.interfaces."enp3s0".ipv6.addresses = [{ address = "2607:fea8:7a43:7600::523"; prefixLength = 64; }];
  networking.interfaces."enp3s0".ipv4.addresses = [{ address = "192.168.0.10"; prefixLength = 24; }];
  networking.defaultGateway = { address = "192.168.0.1"; interface = "enp3s0"; };
  networking.defaultGateway6 = { address = "fe80::9050:caff:fe21:cec1"; interface = "enp3s0"; };
  networking.firewall.allowedTCPPorts = [ 25565 26666 ]; #Somtimes Minecraft Servers are run without being explicitly enabled for testing purposes.
  imports =
    [
      ../common.nix
      ../bootloaders/systemd.nix
      ../services/avahi.nix
      ../services/ssh.nix
      ../services/fail2ban.nix
      ../services/gitea.nix
      ../services/plex.nix
      ../services/samba.nix
      ../services/transmission.nix
      ../services/nginx.nix
      #../services/minecraft_server.nix
      #../services/stoneblock.nix
      #../services/satisfactory_server.nix
      #../services/project_ozone_3.nix
      #../services/nextcloud.nix
      #../services/seafile.nix
      ../users/krutonium.nix
      ../users/resin.nix
      ../users/root.nix
      ../users/gameserver.nix
      ../services/synapse.nix
      #../services/invidious.nix
      ../packages/virtual_machines.nix
      #../tweaks/r9_390.nix
      ../packages/GPU_Passthrough/enter_the_matrix.nix
    ];
  #swapDevices = [{
  #  device = "/persist/swap";
  #  size = 1024 * 8; #16GB
  #}];
  nixpkgs.config.allowUnfree = true;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.opengl.extraPackages = [
    pkgs.rocm-opencl-icd
    pkgs.rocm-runtime-ext
  ];

  #Headless Stuff
  #hardware.nvidia.nvidiaPersistenced = true;
  boot.vesa = false;
  #systemd.services."serial-getty@ttyS0".enable = false;
  #systemd.services."serial-getty@hvc0".enable = false;
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@".enable = false;
  boot.kernelParams = [ "panic=1" "boot.panic_on_fail" "intel_iommu=on" ];
  systemd.enableEmergencyMode = false;
  boot.loader.grub.splashImage = null;

  networking.tempAddresses = "disabled";

  #services.openssh = {
  #  enable = true;
  #  hostKeys = [{
  #    path = "/persist/sshd/ssh_host_key";
  #    type = "ed25519";
  #  }];
  #};
  #services.xserver.videoDrivers = [ "nvidia" ];
  environment.systemPackages = [
    pkgs.wget
    pkgs.nano
    pkgs.htop
    pkgs.neofetch
    pkgs.git
    pkgs.screen
    pkgs.steamcmd
    unstable.plex
    pkgs.ldgallery
    pkgs.twitch2youtube
    pkgs.yt-dlp
  ];
  system.stateVersion = "21.11";
}
