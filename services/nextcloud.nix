{ config, pkgs, ...}:
{
    services.nextcloud = {
        enable = true;
        https = true;
        appstoreEnable = true;
        enableImagemagick = true;
        package = pkgs.nextcloud23;
    };    
}
