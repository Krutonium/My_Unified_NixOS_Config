{ config, pkgs, ... }:
let
  mountPoint = "/boot";
  devices = "nodev";
  default = "saved";
in
{
  boot = {
    loader = {
      efi = {
        efiSysMountPoint = mountPoint;
        canTouchEfiVariable = true;
      };
      grub = {
        devices = [ devices ];
        efiSupport = true;
        useOSProber = true;
        default = default;
        enabled = true;
      };
    };
  };
}
