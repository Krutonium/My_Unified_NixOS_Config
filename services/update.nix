{ config, pkgs, pkgs-unstable, ...}:
{
  systemd = {
    services.updateSystems = {
      serviceConfig.Type = "oneshot";
      serviceConfig.User = "krutonium";
      path = with pkgs; [ pkgs.deploy-cs pkgs-unstable.nixUnstable pkgs.nixos-rebuild pkgs.git pkgs.openssh ];
      script = ''
        cd /home/krutonium/NixOS/
        deploy-cs
      '';
      enable = true;
    };
    timers.updateSystems = {
      wantedBy = [ "timers.target" ];
      partOf = [ "updateSystems.service" ];
      timerConfig = {
        OnCalendar = "*-*-* 00,02,04,06,08,10,12,14,16,18,20,22:00:00"; # Every 2 hours
        Unit = "updateSystems.service";
      };
      enable = true;
    };
  };
}
