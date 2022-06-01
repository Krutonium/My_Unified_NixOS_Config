{ pkgs, lib,config, ... }:
{
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # 2. allow jellyfin user to access the graphics card
  users.users.${config.services.jellyfin.user}.extraGroups = [ "video" "render" ];

  # 3. override default hardening measure from NixOS
  systemd.services.jellyfin.serviceConfig.PrivateDevices = lib.mkForce false;
  systemd.services.jellyfin.serviceConfig.DeviceAllow = lib.mkForce [ "/dev/dri/renderD128" ];

  # 4. do not forget to enable jellyfin
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
}