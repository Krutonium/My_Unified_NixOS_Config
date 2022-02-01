{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    https = true;
    appstoreEnable = true;
    enableImagemagick = true;
    package = pkgs.nextcloud23;
    hostName = "nextcloud.krutonium.ca";
    config.adminpassFile = "/var/nextcloud-admin-pass";
  };
}
