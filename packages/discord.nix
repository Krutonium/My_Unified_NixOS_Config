# Specifically to prevent Discord from accessing my Webcams, causing my screen to flash.
{pkgs, config, lib, ...}:
let
    discordScript = pkgs.writeScriptBin "discordWrapper"
      ''
        #!${pkgs.bash}/bin/bash
        firejail discord
      '';
in
{
    environment.systemPackages = [
        pkgs.discord
        pkgs.firejail
        discordScript
    ];
    programs.firejail.enable = true;
    programs.firejail.wrappedBinaries = {
      discord = {
          executable = "${pkgs.discord}/bin/discord";
          profile = ./discord.profile;
      };
    };
}