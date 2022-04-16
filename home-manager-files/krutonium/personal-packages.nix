{ config, pkgs, pkgs-unstable, fetchurl, lib, wrapOBS, fetchFromGitHub, ... }:
let
  unstable = pkgs;
  properly_unstable = pkgs-unstable;
  ndi_file = builtins.fetchurl {
    url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/InstallNDISDK_v4_Linux.tar.gz";
    sha256 = "181ypfj1bl0kljzrfr6037i14ykg2y4plkzdhym6m3z7kcrnm1fl";
  };
  ndi = pkgs.ndi.override { requireFile = lib.const (ndi_file); };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
  #NUR is only available in Home Manager, because I don't want to have it available system wide.
  #It also doesn't have a pinned version because I want it to update, and it will be updated with the rest of the system anyway.
in
{
  home.packages =
    let
      openjdk8-low = pkgs.openjdk8.overrideAttrs (oldAttrs: { meta.priority = 10; });
      obs = (unstable.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.obs-ndi
          pkgs.obs-studio-plugins.obs-websocket
          ndi
        ];
      });
      #openrgb = pkgs-unstable.openrgb.override { fetchFromGitLab = lib.const (openrgb-src); };
      #3.11.27
      gamescope-src = pkgs.fetchFromGitHub {
        owner = "Plagman";
        repo = "gamescope";
        rev = "3.11.27";
        sha256="sha256-aFcyLubAbr3ihskFYHIx6o6SlBksYLrqvhJsXchns1k=";
        fetchSubmodules = true;
      };
      gamescope1 = nur.repos.dukzcry.gamescope.overrideAttrs (oldAttrs: {
        src = gamescope-src;
        preConfigure =  ''
           substituteInPlace meson.build --replace \
           "'examples=false'" \
           "'examples=false', 'logind-provider=systemd'"
        '';
      });
      gamescope = gamescope1.override {
        meson = pkgs-unstable.meson;
        wlroots = pkgs-unstable.wlroots;
        wayland = pkgs-unstable.wayland;
        libdrm = pkgs-unstable.libdrm;
        wayland-protocols = pkgs-unstable.wayland-protocols;
      };

    in
    [
      # Browser
      pkgs.firefox-wayland

      # Gnome Stuff
      pkgs.gnome.gnome-tweaks
      pkgs.gnomeExtensions.dash-to-panel
      pkgs.arc-theme
      pkgs.sweet
      pkgs.ubuntu_font_family
      pkgs.bibata-extra-cursors
      pkgs.gnomeExtensions.appindicator
      pkgs.gnome.dconf-editor
      pkgs.gnomeExtensions.arcmenu
      properly_unstable.gnomeExtensions.burn-my-windows
      properly_unstable.gnomeExtensions.ddterm

      # Development
      openjdk8-low
      pkgs.openjdk17
      pkgs.github-desktop
      pkgs.mono
      #pkgs.jetbrains.rider
      #pkgs.jetbrains.idea-ultimate

      # Media
      pkgs.vlc
      pkgs.spotify
      obs
      pkgs.plexamp

      # Random Stuff
      pkgs.htop
      pkgs.gimp
      pkgs.neofetch
      pkgs.catimg #for neofetch
      pkgs.nmap
      pkgs.gparted
      pkgs.ffmpeg-full
      pkgs.openrgb
      pkgs.calibre
      pkgs.primus

      # Terminal
      pkgs.fish
      pkgs.oh-my-fish
      pkgs.babelfish
      pkgs.powerline-fonts
      pkgs.unzip
      pkgs.youtube-dl

      # Wine/Windows Shit
      pkgs.lutris
      pkgs.bottles

      # Gaming
      # Steam is already installed at the system level because it has special requirements
      unstable.openrct2
      pkgs.jstest-gtk
      properly_unstable.polymc
      unstable.mangohud
      unstable.goverlay
      unstable.dolphin-emu-beta
      #nur.repos.dukzcry.gamescope
      #gamescope

      # File Sync
      pkgs.dropbox
      pkgs.nextcloud-client
      pkgs.transmission-remote-gtk

      # Communications
      unstable.tdesktop
      #unstable.discord
      # Installed Elsewhere - Fucks up Desktop Capture
      unstable.element-desktop
      pkgs.nheko
    ];
  home.file.".jdk/17/".source = pkgs.openjdk17;
  home.file.".jdk/8/".source = pkgs.openjdk8;
}
