{ config, pkgs, ...}:
{
    services.xserver.enable = true;
    hardware.nvidia.modesetting.enable = false;
    programs.xwayland.enable = true;
    services.xserver.displayManager.kde.wayland = true;
    services.xserver.displayManager.kde.nvidiaWayland = true;
    hardware.opengl.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.kde.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };
}