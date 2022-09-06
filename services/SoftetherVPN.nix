{ pkgs, config, ...}:
{
 # SoftetherVPN Server, but Clients will use built in VPN solutions I think
 services.softether = {
   enable = true;
   vpnserver.enable = true;
   dataDir = "/var/lib/softether";
 };
}