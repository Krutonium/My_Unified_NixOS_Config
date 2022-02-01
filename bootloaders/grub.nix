{ config, pkgs, ... }:
{
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    devices = [ "nodev" ];
    efiSupport = true;
    enable = true;
    useOSProber = true;
    default = "saved";
  };
}
