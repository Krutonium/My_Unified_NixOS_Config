{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Krutonium";
    userEmail = "PFCKrutonium@gmail.com";
    lfs.enable = false;
    #TODO: Configure Rebase by default on pull?
  };
}
