{ config, pkgs, pkgs-unstable, ... }: # we add another parameter here
#To configure Fish:
#curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#omf install agnoster

let
  unstable = pkgs-unstable; # TODO: fix that properly in the rest of the file

in
{
  imports = [
    ./dconf.nix
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true; #Fix Icons?
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "krutonium";
  home.homeDirectory = "/home/krutonium";
  home.sessionVariables.EDITOR = "nano";
  home.sessionVariables.VISUAL = "nano";
  home.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  #Install our Packages
  home.packages =
    let
      openjdk17-low = pkgs.openjdk17.overrideAttrs (oldAttrs: { meta.priority = 10; });
    in
    [
      unstable.tdesktop
      pkgs.discord
      pkgs.firefox
      pkgs.wget
      pkgs.gnome.gnome-tweaks
      pkgs.gnomeExtensions.dash-to-panel
      unstable.gnomeExtensions.arcmenu
      pkgs.arc-theme
      pkgs.yaru-theme
      pkgs.sweet
      pkgs.ubuntu_font_family
      unstable.jetbrains.rider
      unstable.jetbrains.idea-ultimate
      pkgs.github-desktop
      pkgs.mono
      pkgs.htop
      pkgs.neofetch
      pkgs.gnomeExtensions.appindicator
      pkgs.obs-studio
      pkgs.dropbox
      pkgs.lutris
      unstable.mangohud
      (pkgs.multimc.override { msaClientID = "81a207c0-a53c-46a3-be07-57d2b28c1643"; })
      openjdk17-low
      pkgs.openjdk8
      unstable.goverlay
      unstable.openrct2
      pkgs.vlc
      pkgs.nanorc
      pkgs.openrgb
      pkgs.iconpack-obsidian
      pkgs.bibata-extra-cursors
      pkgs.gnome.dconf-editor
      pkgs.jstest-gtk
      pkgs.quassel
      pkgs.transmission-remote-gtk
      pkgs.fish
      pkgs.oh-my-fish
      pkgs.babelfish
      pkgs.github-desktop
      pkgs.spotify
      pkgs.notepadqq
      unstable.gnomeExtensions.burn-my-windows
      unstable.dolphin-emu-beta
      unstable.mgba
      unstable.mupen64plus
      pkgs.nextcloud-client
      unstable.gnomeExtensions.ddterm
    ];
  programs.git = {
    enable = true;
    userName = "Krutonium";
    userEmail = "PFCKrutonium@gmail.com";
  };

  #What version of Home Manager this config file was created at.
  home.stateVersion = "21.05";
}
