{ config, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
        };
      };
      desktopManager = {
        desktopManager = {
          plasma5 = {
            enable = true;
          };
        };
      };
    };
  };
  hardware = {
    opengl = {
      enable = true;
    };
    nvidia = {
      modesetting = {
        enable = true;
      };
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

  services = {
    pipewire = {
      enable = true;
      alse = {
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
}
