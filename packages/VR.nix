{ pkgs, config, ... }:
{
  # install openhmd, and monado

  environment.systemPackages = [
    pkgs.openhmd
    pkgs.monado
  ];
}
