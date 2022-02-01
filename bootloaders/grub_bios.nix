{ config, pkgs, ... }:
{
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub = {
    devices = [ "nodev" ];
    efiSupport = false;
    enable = true;
    useOSProber = true;
    default = "saved";
  };
}
