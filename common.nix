{ config, pkgs, ... }:
let

in
{
  # First, everything that applies to all machines:
  imports =
    [
      ./packages/scripts.nix
      ./packages/custom-fonts.nix
      #./packages/apple-fonts.nix
      #./packages/minecraft-fonts.nix
      #./packages/remote-builders.nix
    ];

  boot = {
    cleanTmpDir = true;
  };
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
    trustedUsers = [ "@wheel" ];
  };
  time = {
    #Enables Windows Compatability.
    hardwareClockInLocalTime = true;
    timeZone = "America/Toronto";
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = ["nodejs-12.22.12"];
    };
  };

  networking = {
    networkmanager = {
      enable = true;
      insertNameservers = [ "99.248.154.165" "2607:fea8:7a43:7600:428d:5cff:fe54:8996" ];
    };
    tempAddresses = "disabled";
    firewall = {
      enable = true;
    };
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
      "2001:4860:4860::8888"
      "2606:4700:4700::1111"
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console = {
    keyMap = "us";
  };

  # Let me tell you a story about a bad switch that dropped me to an
  # emergency console instead of letting me see what went wrong...
  # https://github.com/NixOS/nixpkgs/issues/147783
  systemd = {
    enableEmergencyMode = false;
    network = {
      wait-online = {
        anyInterface = true;
      };
    };
    services = {
      systemd-udev-settle.enable = false;
    };
  };

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
    pkgs.btop
    pkgs.killall
    pkgs.nix-index
    pkgs.deploy-cs
    pkgs.appimage-run
    pkgs.unison
    pkgs.p7zip
    pkgs.pciutils
    pkgs.android-tools    
  ];

  services = {
    fwupd.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  nix.settings.system-features = [ "i686-linux" ];

  users = {
    mutableUsers = false;
  };



  system = {
    stateVersion = "22.05";
  };
}
