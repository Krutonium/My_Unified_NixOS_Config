{ config, pkgs, pkgs-unstable, fetchurl, lib, wrapOBS, fetchFromGitHub, nur, ... }:
let
  ndi_file = builtins.fetchurl {
    url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/InstallNDISDK_v4_Linux.tar.gz";
    sha256 = "181ypfj1bl0kljzrfr6037i14ykg2y4plkzdhym6m3z7kcrnm1fl";
  };
  ndi = pkgs.ndi.override { requireFile = lib.const (ndi_file); };
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
      #openrgb = nixpkgs-unstable.openrgb.override { fetchFromGitLab = lib.const (openrgb-src); };
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
      #pkgs.calibre
      pkgs.primus

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
      nur.repos.iagocq.parsec
      #nur.repos.dukzcry.gamescope
      #gamescope

      # File Sync
      pkgs.dropbox
      #pkgs.nextcloud-client
      pkgs.transmission-remote-gtk
      pkgs.seafile-client

      # Communications
      pkgs-unstable.tdesktop
      #nixpkgs-unstable.discord
      # Installed Elsewhere - Fucks up Desktop Capture
      pkgs-unstable.element-desktop
      pkgs.nheko
    ];
  home.file.".jdk/17/".source = pkgs.openjdk17;
  home.file.".jdk/8/".source = pkgs.openjdk8;
}
