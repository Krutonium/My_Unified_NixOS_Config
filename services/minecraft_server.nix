{ config, pkgs, ... }:
{
    services.minecraft-server = {
        enable = true;
        openFirewall = true;
        dataDir = /srv/Minecraft;
        eula = true;
    };
}
