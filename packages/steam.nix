{ config, pkgs, ... }:
{

  # Gotta have good old steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  #environment.systemPackages = [ pkgs.gamescope pkgs.mangohud ];
}
