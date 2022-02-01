{ config, ...}:
{
    networking.firewall.allowedTCPPorts = [ 22 1337 ];
    services.openssh = {
        enable = true;
        permitRootLogin = "without-password";
        passwordAuthentication = false;
	ports = [ 22 1337 ];
    };
}
