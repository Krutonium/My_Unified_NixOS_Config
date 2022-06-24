{ config, pkgs, ...}:
{
  systemd = {
    services.updateSystems = {
      serviceConfig.Type = "oneshot";
      path = with pkgs; [ pkgs.deploy-cs ];
      script = ''
        deploy-cs
      '';
      enable = true;
    };
    timers.syncronize-devices = {
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