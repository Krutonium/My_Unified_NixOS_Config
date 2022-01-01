{ config, pkgs, lib, ... }:
let
    unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
    {config = config.nixpkgs.config;};
in
{
    networking.firewall.allowedTCPPorts = [ 32400 ];
    services.plex = {
        enable = true;
        openFirewall = true;
    };
    imports = [ unstable.plex ];
}