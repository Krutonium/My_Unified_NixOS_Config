{ config, pkgs, pkgs-unstable, fetchurl, lib, wrapOBS, ... }:
let
  unstable = pkgs-unstable;
  ndi_file = builtins.fetchurl {
    url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/InstallNDISDK_v4_Linux.tar.gz";
    sha256 = "181ypfj1bl0kljzrfr6037i14ykg2y4plkzdhym6m3z7kcrnm1fl";
  };
  ndi = pkgs.ndi.override { requireFile = lib.const(ndi_file); };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
  };
  #NUR is only available in Home Manager, because I don't want to have it available system wide.
  #It also doesn't have a pinned version because I want it to update, and it will be updated with the rest of the system anyway.
in
{
  home.packages =
    let
      openjdk17-low = pkgs.openjdk17.overrideAttrs (oldAttrs: { meta.priority = 10; });
      obs = (unstable.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.obs-ndi
          pkgs.obs-studio-plugins.obs-websocket
          ndi
        ];
      });
    in
    [
      # Browser
      pkgs.firefox

      # Gnome Stuff
      pkgs.gnome.gnome-tweaks
      pkgs.gnomeExtensions.dash-to-panel
      pkgs.arc-theme
      pkgs.yaru-theme
      pkgs.sweet
      pkgs.ubuntu_font_family
      pkgs.iconpack-obsidian
      pkgs.bibata-extra-cursors
      pkgs.gnomeExtensions.appindicator
      pkgs.gnome.dconf-editor
      unstable.gnomeExtensions.arcmenu
      unstable.gnomeExtensions.burn-my-windows
      unstable.gnomeExtensions.ddterm

      # Development
      openjdk17-low
      pkgs.openjdk8
      pkgs.github-desktop
      pkgs.mono
      unstable.jetbrains.rider
      unstable.jetbrains.idea-ultimate

      # Media
      pkgs.vlc
      pkgs.spotify
      obs

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
      unstable.polymc
      unstable.mangohud
      unstable.goverlay
      unstable.dolphin-emu-beta
      nur.repos.dukzcry.gamescope

      # File Sync
      pkgs.dropbox
      pkgs.nextcloud-client
      pkgs.transmission-remote-gtk

      # Communications
      unstable.tdesktop
      #unstable.discord
      # Installed Elsewhere - Fucks up Desktop Capture
      unstable.element-desktop
    ];
}
