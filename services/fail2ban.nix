{ config, ...}:
{
    services.fail2ban = {
	enable = true;
	ignoreIP = [ "192.168.0.0/16" ];
    };
}
