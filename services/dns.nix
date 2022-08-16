{ pkgs, config, ...}:
{
services.coredns.enable = true;
services.coredns.config =
  ''
    . {
      # Cloudflare and Google
      forward . 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
      cache
    }
    hosts {
       192.168.0.10 uwebserver.local
       192.168.0.20 umsilaptop.local
       192.168.0.40 ugamingpc.local
       fallthrough
    }
    }
  '';
networking.firewall.allowedTCPPorts = [ 53 ];
networking.firewall.allowedUDPPorts = [ 53 ];
}
