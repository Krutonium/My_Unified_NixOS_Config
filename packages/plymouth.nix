{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.plymouth
  ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "tribar";
}
