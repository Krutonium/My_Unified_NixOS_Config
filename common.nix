{ config, pkgs, ... }:
let

in
{
  # First, everything that applies to all machines:
  imports =
    [
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

  time.timeZone = "America/Toronto";

  # Use Systemd networking with networkmanager.
  networking = {
    useDHCP = false;
    networkmanager.enable = true;
    useNetworkd = true;
    firewall.enable = true;
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };

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
    pkgs.pinentry-gnome
    pkgs.ripgrep
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.trustedUsers = [ "@wheel" ];
  system.stateVersion = "21.11";
}
