{ config, pkgs, nixpkgs-unstable, ... }:
{
  services.xserver.enable = true;
  hardware.nvidia.modesetting.enable = false;
  programs.xwayland.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  hardware.opengl.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  hardware.pulseaudio.enable = false;
  #security.pam.services.gdm.enableGnomeKeyring = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.xserver.displayManager.gdm.autoSuspend = false;
  #services.xserver.displayManager.autoLogin.user = "krutonium";
  #services.xserver.displayManager.autoLogin.enable = true;
}
