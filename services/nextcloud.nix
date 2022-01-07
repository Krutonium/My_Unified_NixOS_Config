{ config, pkgs, ...}:
{
    services.nextcloud = {
        enable = true;
        https = true;
        appstoreEnable = true;
        enableImagemacgick = true;
    };    
}
