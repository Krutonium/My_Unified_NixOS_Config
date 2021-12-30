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
        <nixos-hardware/common/pc>
        <nixos-hardware/common/pc/ssd>
        <nixos-hardware/common/cpu/amd>
        <nixos-hardware/common/gpu/amd>
    ];

    #Set Hostname
    networking.hostName = Hostname;

    # bootloader
    boot.initrd.supportedFilesystems = [ "zfs" ];
    boot.supportedFilesystems = [ "zfs" ];
    networking.hostId = "27c52aa1";

    # VL805 Bug
    boot.kernelParams = [ "iommu=soft" ];

    # AMDGPU
    boot.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    # X11/Wayland
    services.xserver.enable = true;
    hardware.nvidia.modesetting.enable = false;
    programs.xwayland.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    services.xserver.displayManager.gdm.nvidiaWayland = true;
    hardware.opengl.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    boot.extraModulePackages = [ kernel.zenpower ];
    boot.blacklistedKernelModules =  [ "k10temp" ];

    #Switch from Pulse to Pipewire
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

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
    programs.steam.enable = true;
    hardware.steam-hardware.enable = true;
    system.stateVersion = "21.11";
}
