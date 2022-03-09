{ config, pkgs, ...}:
{
  services.invidious = {
    enable = true;
    domain = "insynthious.krutonium.ca";
    nginx.enable = true;
  };
}