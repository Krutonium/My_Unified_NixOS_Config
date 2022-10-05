{ pkgs, config, ... }:
{
  services.syncthing = {
    enable = true;
    user = "krutonium";
  };
}
