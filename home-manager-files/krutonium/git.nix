{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Krutonium";
    userEmail = "PFCKrutonium@gmail.com";
    #TODO: Configure Rebase by default on pull?
  };
}
