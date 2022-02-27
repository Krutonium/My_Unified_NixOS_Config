{ pkgs, config, ...}:
{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = [
    pkgs.virt-manager
  ];
}