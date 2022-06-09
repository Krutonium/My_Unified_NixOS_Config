{ pkgs, config, fetchurl, appimageTools, ...}:
let
  pkgSrc = builtins.fetchurl {
    url = "https://client-updates-cdn77.badlion.net/BadlionClient";
    sha256 = "0ixngc740nxdlqhkykfqyk6b5ypmk0bhp601z5ycnf5xp9mrmccf";
  };
   BadClient = pkgs.appimageTools.wrapType2 { # or wrapType1
    name = "BadlionClient";
    src = pkgSrc;
    extraPkgs = pkgs: with pkgs; [ pkgs.jdk8 pkgs.jdk ];
  };
in
{
  environment.systemPackages = [ BadClient ];
  # TODO: Desktop Icon
}