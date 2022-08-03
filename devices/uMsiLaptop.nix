{ lib, config, pkgs, ... }:
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
  #parsec = pkgs.callPackage ../packages/parsec.nix {};
in
{
  # Set our Kernel
  boot.kernelPackages = kernel;
  imports = [
    ../bootloaders/systemd.nix
    ../users/krutonium/user.nix
    ../users/root/user.nix
    ../services/ssh.nix
    ../services/fail2ban.nix
    ../desktops/gnome.nix
    ../tweaks/mitigations.nix
    ../packages/dotnet.nix
    ../packages/steam.nix
    ../packages/wine.nix
    ../packages/ccache.nix
    #../packages/waydroid.nix
    ../packages/plymouth.nix
    ../services/avahi.nix
    ../packages/discord.nix
    ../packages/candy-icons.nix
    ../packages/virtual_machines.nix
    ../packages/badlion.nix
    ../services/mount_sshfs.nix
    ../tweaks/mesa.nix
  ];
  swapDevices = [{
    device = "/swap";
    size = 1024 * 16; #16GB
  }];


  #environment.systemPackages = [ parsec ];

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  
  #nix.settings.system-features = [ "gccarch-haswell" ];  
  #nixpkgs.localSystem = {
  #  gcc.arch = "haswell";
  #  gcc.tune = "haswell";
  #  system = "x86_64-linux";
  #};

  #environment.systemPackages = [ nvidia-offload ];

  #services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  #hardware.nvidia.modesetting.enable = true;
  #hardware.nvidia.prime = {
  #  offload.enable = true;
  #  nvidiaBusId = "PCI:1:0:0";
  #  intelBusId = "PCI:0:2:0";
  #};
  #services.xserver.screenSection = ''
  #  Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
  #  Option         "AllowIndirectGLXProtocol" "off"
  #  Option         "TripleBuffer" "on"
  #'';
  networking.useNetworkd = true;
  networking.hostName = Hostname;
}
