{ config, ... }:
{
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "192.168.0.0/16" "83.114.116.175" "211.31.98.192" ];
  };
}
