{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.plymouth
  ];
}