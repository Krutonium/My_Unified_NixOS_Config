{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.netbootxyz.enable = true;
}