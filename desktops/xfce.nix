{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  hardware.nvidia.modesetting.enable = false;
  programs.xwayland.enable = true;
  hardware.opengl.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
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
