{ pkgs, config }:
{
services.coredns.enable = true;
services.coredns.config =
  ''
    . {
      # Cloudflare and Google
      forward . 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
      cache
    }

    local {
      template IN A  {
          answer "{{ .Name }} 0 IN A 127.0.0.1"
      }
    }
  '';
networking.firewall.allowedTCPPorts = [ 53 ];
networking.firewall.allowedUDPPorts = [ 53 ];
}
