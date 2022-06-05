{ lib, config, pkgs, pkgs-unstable, ... }:
let
  kernel = pkgs.linuxPackages_zen;
  Hostname = "uMsiLaptop";
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  imports = [
    ../bootloaders/systemd.nix
    ../users/krutonium.nix
    ../users/root.nix
    ../services/ssh.nix
    ../services/fail2ban.nix
    ../desktops/gnome.nix
    #../desktops/xfce.nix
    ../tweaks/mitigations.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/ccache.nix
    ../packages/waydroid.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/candy-icons.nix
    ../packages/virtual_machines.nix
  ];
  swapDevices = [{
    device = "/swap";
    size = 1024 * 16; #16GB
  }];
  #nix.settings.system-features = [ "gccarch-haswell" ];  
  #nixpkgs.localSystem = {
  #  gcc.arch = "haswell";
  #  gcc.tune = "haswell";
  #  system = "x86_64-linux";
  #};

  environment.systemPackages = [ nvidia-offload ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.prime = {
    offload.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  home-manager.users.krutonium = import ../home-manager-files/krutonium/home.nix;
  home-manager.users.root = import ../home-manager-files/root/root.nix;
  networking.hostName = Hostname;
}
