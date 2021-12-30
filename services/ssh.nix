{ config, ...}:
{
    services.firewall.allowedTCPPorts = [ 22 ];
}