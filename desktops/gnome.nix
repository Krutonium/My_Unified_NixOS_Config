{ config, pkgs, pkgs-unstable, ... }:
let
  mesa = pkgs.mesa.override { galliumDrivers = [ "zink" "r600" "swrast" "nouveau" "i915" "iris" "auto" ]; };
  mesa32 = pkgs.driversi686Linux.mesa.override { galliumDrivers = [ "zink" "r600" "swrast" "nouveau" "i915" "iris" "auto" ]; };
in
{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
          autoSuspend = false;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
      useGlamor = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
      jack = {
        enable = true;
      };
    };
  };
  hardware = {
    opengl = {
      enable = true;
      #package = mesa;
      #package32 = mesa32;
    };
    pulseaudio = {
      enable = false;
    };
  };
  programs = {
    xwayland = {
      enable = true;
    };
  };
  security = {
    rtkit = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs-unstable; [
    gnome.gnome-session
    gnome.mutter
    gnome.gnome-shell
  ];
  #environment.enableDebugInfo = true;
  #nixpkgs.overlays = [
  #  (final: prev: {
  #    gnome = prev.gnome.overrideScope' (gfinal: gprev: {
  #      gnome-session = gprev.gnome-session.overrideAttrs (attrs: {
  #        separateDebugInfo = true;
  #      });
  #      gnome-shell = gprev.gnome-shell.overrideAttrs (attrs: {
  #        separateDebugInfo = true;
  #      });
  #      mutter = gprev.mutter.overrideAttrs (attrs: {
  #        separateDebugInfo = true;
  #      });
  #    });
  #  })
  #];
}
