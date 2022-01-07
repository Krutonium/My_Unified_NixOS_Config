{ config, pkgs, ...}:
{
    services.nextcloud = {
        enable = true;
        https = true;
        appstoreEnable = true;
        enableImagemacgick = true;
        package = pkgs.nextcloud23;
    };    
}
