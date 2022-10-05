{ pkgs, config, ... }:
{
  services.softether = {
    enable = true;
    vpnclient.enable = true;
    dataDir = "/var/lib/softether";
  };
  environment.systemPackages = [ pkgs.softether ];
}
