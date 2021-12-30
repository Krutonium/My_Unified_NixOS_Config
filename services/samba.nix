{ config, pkgs, ... }:
{
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