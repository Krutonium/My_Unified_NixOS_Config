{ config, pkgs, ...}:
#This is the configuration specific to my Gaming Desktop PC.
let
    kernel = pkgs.linuxPackages_zen;
    Username = "krutonium";
    Hostname = "Gaming-PC";
in
{
    imports = [ ./bootloader-grub.nix ];
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

    boot.extraModulePackages = [ kernel.nvidia_x11 kernel.zenpower ];
    boot.blacklistedKernelModules =  [ "nouveau" "nvidia_drm" "nvidia_modeset" "k10temp" ];

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
    users.users.krutonium = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwlUAQPu27Tci5RubNf+ybNBif0c5SEBcLV+C2H36TEAddz/A3q8l4Jgfbyg04ycOe8Cldlh5jZVqOiPexoM9pJ+B4oOKmvVEynr30VS5unptPblbOyWIYhj3QtjGT9grzj/3N9W8ACzNhXnMOs0DZwe1ytAWw0BUe5BUbrLcEPKiZvlitZvxUF3Q6/MI7FffUmmpmmccLZXA9chygs3I28vT8YOWfgbegydX1X1zXbDcaV+/m5eJtLAWNLTmFbyL0G5aPBqEKNQg9YitMK0cJqcFaXQEX0bT2jaJdGUJcp3XB50/1D0s727NWPfuqpE+POjhYjuSp64z3/22HyjDK1WyWhTUhTM1PYQogyv6kaIGz8i5qZ5fc5QMHKBAmvXz/dxPywvUtylqOnMlmPmIzezoYuD6okq2altPfEKc3kQ+Ah+tv0XPlxxzh5ID8HZVLP4JV+HCzUoSc8KYKEMUL0GzMmgd1Td16bp70waK3R8uBBDVfjesfqf7vRVS99Ns= krutonium@krutonium-pc" ];
    };

    environment.systemPackages = [
          pkgs.linuxPackages.nvidia_x11
          pkgs.linuxPackages.zenpower
          pkgs.home-manager
          pkgs.zfs
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
