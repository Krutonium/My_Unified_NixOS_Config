# Specifically to prevent Discord from accessing my Webcams, causing my screen to flash.
{pkgs, config, lib, ...}:
{
    environment.systemPackages = [
        pkgs.discord
        pkgs.firejail
    ];
    programs.firejail.wrappedBinaries = {
      discord = {

          executable = "${lib.getBin pkgs.discord}/bin/discord";
          profile = "${pkgs.firejail}/etc/firejail/discord.profile";
      };
    };
}