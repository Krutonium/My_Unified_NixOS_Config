{ config, pkgs, lib, ... }:
{
    # No port forwarding as NGINX is forwarding for us.
    services.gitea = {
        enable = true;
        appName = "Krutonium's Gitea Service";
        database = {
            type = "sqlite3";
        };
        domain = "gitea.krutonium.ca";
        rootUrl = "https://gitea.krutonium.ca/";
        httpPort = 3001;
        cookieSecure = true;
        ssh.enable = false;
	    disableRegistration = true;
	};
 }