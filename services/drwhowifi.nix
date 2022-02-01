{ config, pkgs, ... }:
let
  ssid = "ᒣᒥப߹/ΔП";
  password = "nottherealpassword";
in
{
  systemd.services.drwhowifi = {
    description = "A satisfying wifi";
    serviceConfig = {
      Type = "simple";
      User = "krutonium";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "networking.target" ];
    path = [ pkgs.networkmanager ];
    script = ''
      nmcli radio wifi on
      nmcli dev wifi hotspot ifname wlp4s0 ssid "${ssid}" password "${password}"
    '';
    enable = true;
  };
}
