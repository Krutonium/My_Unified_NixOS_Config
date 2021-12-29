{ config, pkgs, ...}:
#This is the configuration specific to my Gaming Desktop PC.
let
in
{
  #bootloader
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "27c52aa1";
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    devices = [ "nodev" ];
    efiSupport = true;
    enable = true;
    useOSProber = true;
    default = "saved";
  };

  #VL805 Bug
  boot.kernelParams = [ "iommu=soft" ];

}