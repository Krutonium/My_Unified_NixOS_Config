{ pkgs, config, ...}:
# Install Unison and create syncronization tasks using systemd tasks
let
  syncronize = pkgs.writeShellScriptBin "syncronize" ''
    # Run unison and sync to server

  '';

in
{
  environment.systemPackages = [ pkgs.unison syncronize ];
  systemd = {
    services.syncronize-devices = {
      serviceConfig.Type = "oneshot";
      path = with pkgs; [ unison bash ];
      script = ''
        unison /home/krutonium ssh://192.168.0.20
        unison /home/krutonium ssh://192.168.0.40
      '';
      enable = false;
    };
    timers.syncronize-devices = {
      wantedBy = [ "timers.target" ];
      partOf = [ "syncronize-devices.service" ];
      timerConfig = {
        OnCalendar = "*:0/5"; # Every 5 minutes
        Unit = "syncronize-devices.service";
      };
      enable = false;
    };
  };

}