{ config, pkg, ... }:
{
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
}