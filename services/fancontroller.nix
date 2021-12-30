{ config }:
{
    systemd.services.betterfancontroller = {
        description = "Better Fan Controller";
        serviceConfig = {
            Type = "simple";
            ExecStart = "/run/current-system/sw/bin/dotnet /home/krutonium/BetterFanController/BetterFanController/bin/Debug/net6.0/BetterFanController.dll";
            ExecStop = "";
            Restart = "always";
            User = "root";
            Environment = "HOME=/root/";
        };
        wantedBy = [ "multi-user.target" ];
    };
    systemd.services.betterfancontiller.enable = true;
}
