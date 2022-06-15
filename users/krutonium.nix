{ config, pkgs, ... }:
let
  fetchKeys = username:
    (builtins.fetchurl "https://github.com/${username}.keys");
in
{
  users.users.krutonium = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
    openssh.authorizedKeys.keyFiles = [ (fetchKeys "krutonium" ) ];
    hashedPassword = "$6$l5HeZlsZILfJPHoJ$bE95YsS6Xu1kTj9RgPKpd4JblUsoA35UmCrqFdr5N71HNa3T3SA3Nw.RxT4ifqF239DzYECcyZQZQGLCtFb8W/";
  };
  users.extraGroups.vboxusers.members = [ "krutonium" ];
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
}
