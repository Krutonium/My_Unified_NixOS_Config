{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Krutonium";
    userEmail = "PFCKrutonium@gmail.com";
    lfs.enable = true;
    #TODO: Configure Rebase by default on pull?
  };
}
