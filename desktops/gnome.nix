{ config, pkgs, pkgs-unstable, ... }:
let

  mesa = (pkgs.mesa.override {
    galliumDrivers = [ "zink" "iris" "i915" "radeonsi" "swrast" ];
    vulkanDrivers = [ "amd" "intel" "swrast" ];
    enableGalliumNine = false;
    enableOSMesa = true;
    enableOpenCL = true;
  }).overrideAttrs (old: {
    mesonFlags = (lib.lists.remove "-Dxvmc-libs-path=${placeholder "drivers"}/lib" old.mesonFlags) ++ [
      "-D vulkan-layers=device-select,overlay"
    ];
    postInstall = old.postInstall + ''
      ln -s -t $drivers/lib/ ${pkgs.vulkan-loader}/lib/lib*
      mv -t $drivers/lib $out/lib/libVkLayer*
      for js in $drivers/share/vulkan/{im,ex}plicit_layer.d/*.json; do
        substituteInPlace "$js" --replace '"libVkLayer_' '"'"$drivers/lib/libVkLayer_"
      done
    '';
  });

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
      package = mesa;
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

  #environment.systemPackages = with pkgs-unstable; [
  #  gnome.gnome-session
  #  gnome.mutter
  #  gnome.gnome-shell
  #];
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
