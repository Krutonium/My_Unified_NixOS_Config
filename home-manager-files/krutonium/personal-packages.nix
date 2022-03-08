{ config, pkgs, ... }:
let
  unstable = pkgs-unstable;
in
{
  home.packages =
    let
      openjdk17-low = pkgs.openjdk17.overrideAttrs (oldAttrs: { meta.priority = 10; });
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
      pkgs.obs-studio
      pkgs.obs-studio-plugins.obs-ndi

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

    ];
}
