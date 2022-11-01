{ config, pkgs, ... }:
{
  users.users.krutonium = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBGydZMghVpYF+glHje55hN0/00i9nOEA+OP4A/eneXp" ];
    hashedPassword = "$6$l5HeZlsZILfJPHoJ$bE95YsS6Xu1kTj9RgPKpd4JblUsoA35UmCrqFdr5N71HNa3T3SA3Nw.RxT4ifqF239DzYECcyZQZQGLCtFb8W/";
  };
  users.extraGroups.vboxusers.members = [ "krutonium" ];
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  home-manager.users.krutonium =
    if (config.networking.hostName == "uWebServer") then
      { ... }: { }
    else
      import ./home-manager.nix;
}
