{ config, pkgs, pkgs-unstable, fetchurl, lib, wrapOBS, ... }:
let
  unstable = pkgs-unstable;
  ndi = pkgs.ndi.override ({requireFile = lib.const(builtins.fetchurl https://downloads.ndi.tv/SDK/NDI_SDK_Linux/InstallNDISDK_v4_Linux.tar.gz);});

in
{
  home.packages =
    let
      openjdk17-low = pkgs.openjdk17.overrideAttrs (oldAttrs: { meta.priority = 10; });
      obs = (unstable.wrapOBS {
        plugins = [
          pkgs.obs-studio-plugins.obs-gstreamer
          pkgs.obs-studio-plugins.obs-ndi
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

      # File Sync
      pkgs.dropbox
      pkgs.nextcloud-client
      pkgs.transmission-remote-gtk

      # Communications
      unstable.tdesktop
      unstable.discord
      unstable.element-desktop
    ];
}
