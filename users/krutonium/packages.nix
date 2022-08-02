{ config, pkgs, lib, ... }:
let

in
{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  home.packages =
    let
      openjdk8-low = pkgs.openjdk8.overrideAttrs (oldAttrs: { meta.priority = 10; });
      dotnet = (with pkgs.dotnetCorePackages; combinePackages [ sdk_5_0 sdk_6_0 ]);

      # Run Idea and Rider using steam-run to fix plugins not working.
      ideaScript = pkgs.writeShellScriptBin "idea-ultimate"
      ''
        ${pkgs.steam-run}/bin/steam-run ${pkgs.jetbrains.idea-ultimate}/bin/idea-ultimate
      '';
      idea = pkgs.jetbrains.idea-ultimate.overrideAttrs (oldAttrs: { meta.priority = 10; });
      riderScript = pkgs.writeShellScriptBin "rider"
      ''
        ${pkgs.steam-run}/bin/steam-run ${pkgs.jetbrains.rider}/bin/rider
      '';
      rider = pkgs.jetbrains.rider.overrideAttrs (oldAttrs: { meta.priority = 10; });
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
      idea
      ideaScript
      rider
      riderScript
      #pkgs.jetbrains.rider
      #pkgs.jetbrains.idea-ultimate
      pkgs.gitkraken
      dotnet

      # Keyboard Stuff
      pkgs.unzip
      pkgs.qmk
      pkgs.qmk-udev-rules
      pkgs.arduino
      pkgs.gcc11
      pkgs.pkgsCross.avr.buildPackages.gcc
      pkgs.avrdude
      pkgs.gcc-arm-embedded
      pkgs.gnumake
      pkgs.git
      pkgs.python39Full

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
      pkgs.polymc
      pkgs.mangohud
      pkgs.goverlay
      pkgs.dolphin-emu-beta
      pkgs.heroic
      pkgs.steam-run

      # File Sync
      pkgs.dropbox
      #pkgs.nextcloud-client
      pkgs.transmission-remote-gtk
      pkgs.seafile-client

      # Communications
      pkgs.tdesktop
      pkgs.betterdiscord-installer
      pkgs.betterdiscordctl
      pkgs.element-desktop
    ];
}
