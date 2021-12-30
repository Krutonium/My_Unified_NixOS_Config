{ config, pkgs, ... }:
    services.avahi = {
        enable = true;
        publish = {
            enable = true;
            addresses = true;
            workstation = true;
            domain = true;
            hinfo = true;
            userServices = true;
        };
    };
}