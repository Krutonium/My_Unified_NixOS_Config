{ config, pkgs, lib, ... }:
{
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
    ssh = {
      enable = true;
      clonePort = 22;
    };
    disableRegistration = true;
  };
}
