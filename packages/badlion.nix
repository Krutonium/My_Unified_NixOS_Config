{ pkgs, config, fetchurl, appimageTools, makeDesktopItem, ...}:
let
  pkgSrc = builtins.fetchurl {
    url = "https://client-updates-cdn77.badlion.net/BadlionClient";
    sha256 = "0ixngc740nxdlqhkykfqyk6b5ypmk0bhp601z5ycnf5xp9mrmccf";
  };
  BadlionClient = pkgs.appimageTools.wrapType2 { # or wrapType1
    name = "BadlionClient";
    src = pkgSrc;
    extraPkgs = pkgs: with pkgs; [ pkgs.jdk8 pkgs.jdk ];
  };
  BadlionClientIcon = pkgs.makeDesktopItem {
    name = "Badlion Client";
    exec = "BadlionClient";
    icon = "minecraft";
    comment = "A Minecraft Client with Anticheat!";
    desktopName = "Badlion Client";
    genericName = "Badlion Client";
    categories = [ "X-games" ];
  };
in
{
  environment.systemPackages = [ BadlionClient BadlionClientIcon ];
}