{ pkgs, config, ...}:
{
 # SoftetherVPN Server, but Clients will use built in VPN solutions I think
 services.softether = {
   vpnserver.enable = true;
   dataDir = "/var/lib/softether";
 };
}