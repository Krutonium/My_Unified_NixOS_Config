{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [ 22 1337 ];
  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
    ports = [ 22 ];
  };
}
