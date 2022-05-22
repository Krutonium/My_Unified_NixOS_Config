{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [ 22 55 ];
  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
    ports = [ 22 55 ];
    forwardX11 = true;
  };
}
