{ pkgs, config, ...}:
{
 services.softether = {
   enable = true;
   dataDir = "/var/lib/softether";
 };

}