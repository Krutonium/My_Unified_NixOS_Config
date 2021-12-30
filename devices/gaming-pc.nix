{ config, pkgs, ...}:
#This is the configuration specific to my Gaming Desktop PC.

#Run sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
let
    kernel = pkgs.linuxPackages_zen;
    Hostname = "Gaming-PC";
in
{
    imports = [
        ../bootloaders/grub.nix
        ../users/krutonium.nix
        ../services/fancontroller.nix
        ../services/ssh.nix
        ../desktops/gnome.nix
        <nixos-hardware/common/pc>
        <nixos-hardware/common/pc/ssd>
        <nixos-hardware/common/cpu/amd>
        <nixos-hardware/common/gpu/amd>
    ];

    #Set Hostname
    networking.hostName = Hostname;

    boot.initrd.supportedFilesystems = [ "zfs" ];
    boot.supportedFilesystems = [ "zfs" ];
    networking.hostId = "27c52aa1";

    # VL805 Bug
    boot.kernelParams = [ "iommu=soft" ];

    # AMDGPU
    boot.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    # CPU Temperature
    boot.extraModulePackages = [ kernel.zenpower ];
    boot.blacklistedKernelModules =  [ "k10temp" ];

    environment.systemPackages = [
          pkgs.linuxPackages.nvidia_x11
          pkgs.linuxPackages.zenpower
          pkgs.home-manager
          pkgs.zfs
          (with pkgs.dotnetCorePackages; combinePackages [
              sdk_3_1
              sdk_5_0
              sdk_6_0
          ])
    ];

    # ZFS is a pain in the ass with it's own mounting when paired with the hardware config.
    # Disabling the service is the easiest solution.
    systemd.services = {
        zfs-mount = {
            enable = false;
            restartIfChanged = false;
        };
    };

    # Gotta have good old steam
    programs.steam.enable = true;
    hardware.steam-hardware.enable = true;
    system.stateVersion = "21.11";
}
