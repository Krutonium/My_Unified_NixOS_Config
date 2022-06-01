{ config, pkgs, pkgs-unstable, fetchurl, lib, wrapOBS, fetchFromGitHub, ... }:
let
  ndi_file = builtins.fetchurl {
    url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/InstallNDISDK_v4_Linux.tar.gz";
    sha256 = "181ypfj1bl0kljzrfr6037i14ykg2y4plkzdhym6m3z7kcrnm1fl";
  };
  ndi = pkgs.ndi.override { requireFile = lib.const (ndi_file); };
  #nur = import (builtins.fetchTarball
  #{
  #  url = "https://github.com/nix-community/NUR/archive/768c7d968dc9b90b6fa6f85374669de3e57d70ca.tar.gz";
  #  sha256="sha256:1ac9fgalrra3ys38qpbi6rkr0dhadxrjjbn5z184rhl1cc8bp47l";
  #}
  #NUR is only available in Home Manager, because I don't want to have it available system wide.
  #It also doesn't have a pinned version because I want it to update, and it will be updated with the rest of the system anyway.
in
{
  home.packages =
    let
      openjdk8-low = pkgs.openjdk8.overrideAttrs (oldAttrs: { meta.priority = 10; });
      obs = (pkgs.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.obs-ndi
          pkgs.obs-studio-plugins.obs-websocket
          ndi
        ];
      });

    in
    [
      # Browser
      pkgs.firefox-wayland

      # Gnome Stuff
      pkgs.gnome.gnome-tweaks
      pkgs.gnomeExtensions.dash-to-panel
      #pkgs.arc-theme
      #pkgs.sweet
      pkgs.whitesur-gtk-theme
      pkgs.whitesur-icon-theme
      pkgs.ubuntu_font_family
      pkgs.bibata-extra-cursors
      pkgs.gnomeExtensions.appindicator
      pkgs.gnome.dconf-editor
      pkgs.gnomeExtensions.arcmenu

      # Development
      openjdk8-low
      pkgs.openjdk17
      pkgs.github-desktop
      pkgs.mono
      pkgs.jetbrains.rider
      pkgs.jetbrains.idea-ultimate

      # Media
      pkgs.vlc
      pkgs.spotify
      pkgs.obs-studio
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
      #pkgs.calibre
      pkgs.primus
      pkgs.nixpkgs-review
      pkgs.libreoffice
      pkgs.mate.engrampa

      # Terminal
      pkgs.fish
      pkgs.oh-my-fish
      pkgs.babelfish
      pkgs.powerline-fonts
      pkgs.unzip
      pkgs.yt-dlp
      pkgs.matrix-synapse-tools.synadm

      # Wine/Windows Shit
      pkgs.lutris
      pkgs.bottles

      # Gaming
      # Steam is already installed at the system level because it has special requirements
      pkgs.openrct2
      pkgs.jstest-gtk
      pkgs-unstable.polymc
      pkgs-unstable.mangohud
      pkgs-unstable.goverlay
      pkgs-unstable.dolphin-emu-beta
      #nur.repos.iagocq.parsec
      #nur.repos.dukzcry.gamescope
      #gamescope

      # File Sync
      pkgs.dropbox
      #pkgs.nextcloud-client
      pkgs.transmission-remote-gtk
      pkgs.seafile-client

      # Communications
      pkgs-unstable.tdesktop
      pkgs.betterdiscord-installer
      pkgs.betterdiscordctl
      #nixpkgs-unstable.discord
      # Installed Elsewhere - Fucks up Desktop Capture
      pkgs-unstable.element-desktop
      pkgs.nheko
    ];
  home.file.".jdk/17/".source = pkgs.openjdk17;
  home.file.".jdk/8/".source = pkgs.openjdk8;
}
