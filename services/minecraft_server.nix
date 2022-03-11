{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 25566 ];
  services.minecraft-server = {
    enable = true;
    openFirewall = true;
    dataDir = "/srv/Minecraft";
    eula = true;
  };
}
