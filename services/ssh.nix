{ config, ...}:
{
    networking.firewall.allowedTCPPorts = [ 22 ];
    services.openssh = {
        enable = true;
        permitRootLogin = "no";
        passwordAuthentication = false;
    };
}
