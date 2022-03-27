{ config, pkgs, ... }:
{
  users.users.krutonium = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBGydZMghVpYF+glHje55hN0/00i9nOEA+OP4A/eneXp krutonium@uHPLaptop - Wed, Mar 16, 2022 @ 4:03 AM"
    ];
  };
  users.extraGroups.vboxusers.members = [ "krutonium" ];
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
}
