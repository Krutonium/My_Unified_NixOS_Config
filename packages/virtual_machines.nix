{ pkgs, config, ... }:
{
  virtualisation.libvirtd.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.docker.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = [
    pkgs.virt-manager
  ];
}
