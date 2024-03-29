{ pkgs-unstable, config, ... }:
{
  services.seafile = {
    enable = true;
    workers = 8;
    seafileSettings.fileserver = {
      port = 8082;
      host = "127.0.0.1";
    };
    seafilePackage = pkgs-unstable.seafile-server;
    adminEmail = "PFCKrutonium@gmail.com";
    initialAdminPassword = "badPassword";
    ccnetSettings.General.SERVICE_URL = "https://seafile.krutonium.ca";
  };
}
