{ config, pkgs, pkgs-unstable, ... }: # we add another parameter here
#To configure Fish:
#curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#omf install agnoster

let
  unstable = pkgs-unstable; # TODO: fix that properly in the rest of the fil
in
{
  imports = [
    ./dconf.nix
    ./git.nix
    ./config.nix
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
      pkgs.firefox
      pkgs.wget
      pkgs.gnome.gnome-tweaks
      pkgs.gnomeExtensions.dash-to-panel
      pkgs.arc-theme
      pkgs.yaru-theme
      pkgs.sweet
      pkgs.ubuntu_font_family
      pkgs.github-desktop
      pkgs.mono
      pkgs.htop
      pkgs.neofetch
      pkgs.gnomeExtensions.appindicator
      pkgs.obs-studio
      pkgs.dropbox
      pkgs.lutris
      (pkgs.multimc.override { msaClientID = "81a207c0-a53c-46a3-be07-57d2b28c1643"; })
      openjdk17-low
      pkgs.openjdk8
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
      pkgs.nextcloud-client
      pkgs.element-desktop

      #Unstable Packages
      unstable.tdesktop
      unstable.gnomeExtensions.arcmenu
      unstable.jetbrains.rider
      unstable.jetbrains.idea-ultimate
      unstable.mangohud
      unstable.goverlay
      unstable.openrct2
      unstable.gnomeExtensions.burn-my-windows
      unstable.dolphin-emu-beta
      unstable.mgba
      unstable.gnomeExtensions.ddterm
    ];

  #What version of Home Manager this config file was created at.
  home.stateVersion = "21.05";
}
