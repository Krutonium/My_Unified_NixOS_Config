{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
  services.samba = {
    enable = true;
    securityType = "user";
    shares = {
      media = {
        path = "/media";
        browseable = true;
        "read only" = "no";
      };
      home = {
        path = "/home/krutonium";
        browseable = true;
        "read only" = "no";
      };
      torrents = {
        path = "/transmission";
        browseable = true;
        "read only" = "no";
      };
    };
  };
}
