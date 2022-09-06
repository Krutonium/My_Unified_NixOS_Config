{ pkgs, config, ...}:
{
 services.softether = {
   enable = true;
   dataDir = "/var/lib/softether";
 };
 environment.systemPackages = [ pkgs.softether ];
}