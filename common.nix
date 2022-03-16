{ config, pkgs, ... }:
let

in
{
  # First, everything that applies to all machines:
  imports =
    [
      # Import other files that are used by all associated computers
      #./hardware-configuration.nix
      #./device.nix
      ./packages/scripts.nix
    ];
  #boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;
  # Misc Settings - Optimize for Size, Compatible with Windows time, Enable unfree packages.
  nix.autoOptimiseStore = true;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 3d";
  time.hardwareClockInLocalTime = true;
  nixpkgs.config.allowUnfree = true;

  # We always want 8 GB of Swap.
  swapDevices = [{
    device = "/swap";
    size = 1024 * 8; #8GB
  }];

  time.timeZone = "America/Toronto";

  # This disables DHCP on interfaces that shouldn't have it.
  networking.useDHCP = false;

  # Use Systemd networking with networkmanager.
  networking = {
    networkmanager.enable = true;
    useNetworkd = true;
  };
  # These should be moved to their individual configurations.
  # Add and remove Ethernet Interfaces as needed.
  #networking.interfaces.eno1.useDHCP = true;    #GamingPC
  #networking.interfaces.enp0s25.useDHCP = true; #uWebServer
  #networking.interfaces.enp3s0.useDHCP = true;  #Laptop

  networking.nameservers = [ "8.8.8.8" ];
  networking.firewall.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  # Let me tell you a story about a bad switch that dropped me to an
  # emergency console instead of letting me see what went wrong...
  # https://github.com/NixOS/nixpkgs/issues/147783
  systemd.enableEmergencyMode = false;

  #Install the Base Packages that all systems should have.
  environment.systemPackages = [
    pkgs.nano #Editor
    pkgs.git
    pkgs.tldr #Replace man
    pkgs.colmena
    pkgs.tmux
    pkgs.file
    pkgs.wget
    pkgs.sshfs
    pkgs.usbutils
  ];

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.trustedUsers = [ "@wheel" ];
  system.stateVersion = "21.11";
}
