{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 445 139 2049 ];
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
      share = {
        path = "/home/krutonium/share";
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
  services.nfs.server = {
    enable = true;
    exports = ''
      /home/krutonium/share 192.168.0.10(rw,nohide,insecure,no_subtree_check)
    '';
  };
}
