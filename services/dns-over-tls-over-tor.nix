# Based on https://github.com/piskyscan/dns_over_tls_over_tor
# Provides DNS over HTTPS over TOR on port 8035

{ config, pkgs, ... }:
let
myproxy = {
  type = "socks5";
  host = "127.0.0.1";
  port = 9050;
};
in
{
  services = {
    stubby = {
      enable = true;
      listenAddresses = [ "127.0.0.1@8053" ];
      authenticationMode = "GETDNS_AUTHENTICATION_NONE";
    };
    tor = {
      enable = true;
    };
  };
  programs.proxychains = {
    enable = true;
    proxyDNS = false;
    proxies = { inherit myproxy; };
  };
  systemd.services.secure_dns = {
    description = "Secure DNS on port 8035";
    serviceConfig = {
      Type = "simple";
      User = "root";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "networking.target" ];
    path = [ pkgs.stubby pkgs.tor pkgs.proxychains ];
    script = ''
      proxychains4 stubby
    '';
    enable = true;
  };
}