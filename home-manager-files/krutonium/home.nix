{ config, pkgs, ... }: # we add another parameter here
#To configure Fish:
#curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#omf install agnoster
{
  imports = [
    ./dconf.nix
    ./git.nix
    ./config.nix
    ./personal-packages.nix
    ../../packages/godot-mono.nix
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true; #Fix Icons?
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "krutonium";
  home.homeDirectory = "/home/krutonium";
  home.sessionVariables.EDITOR = "nano";
  home.sessionVariables.VISUAL = "nano";
  home.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

  #What version of Home Manager this config file was created at.
  home.stateVersion = "21.05";
}
