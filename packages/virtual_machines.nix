{ pkgs, config, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = [
    pkgs.virt-manager
  ];
}
