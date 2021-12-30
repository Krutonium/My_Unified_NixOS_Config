{ config, pkgs, lib, ... }:
{
    services.plex = {
        enable = true;
        openFirewall = true;
    };
}