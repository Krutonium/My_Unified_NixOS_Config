{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    https = true;
    appstoreEnable = true;
    enableImagemagick = true;
    maxUploadSize = "10240M"
    package = pkgs.nextcloud24;
    hostName = "nextcloud.krutonium.ca";
    config.adminpassFile = "/persist/nextcloud-admin-pass";
    config.adminuser = "root";
  };
}
