{ config, pkgs, ... }:
{

  # Gotta have good old steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    extraPkgs = pkgs: with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
  #environment.systemPackages = [ pkgs.gamescope pkgs.mangohud ];
}
