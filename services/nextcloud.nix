{ config, pkgs, ...}:
{
    services.nextcloud = {
        enable = true;
        https = true;
        appstoreEnable = true;
        enableImagemagick = true;
        package = pkgs.nextcloud23;
        hostName = "nextcloud.krutonium.ca";
        config.adminpassFile = "/etc/nixos/auth/nextcloudpassword.txt";
    };    
}
