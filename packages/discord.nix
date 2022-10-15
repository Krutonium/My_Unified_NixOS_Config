# Specifically to prevent Discord from accessing my Webcams, causing my screen to flash.
{ pkgs, pkgs-unstable, config, lib, ... }:
let
  discordProfile = pkgs.writeTextFile {
    name = "discordProfile";
    text =
      ''
        blacklist /dev/video*
      '';

  };
  discordScript = pkgs.writeShellScriptBin "Discord"
    ''
      firejail --profile="${discordProfile}" ${pkgs-unstable.discord}/bin/discord "$@"
    '';
  #This makes sure that the script replaces the default symlink in Discord.
  discord-low = pkgs-unstable.discord.overrideAttrs (oldAttrs: { meta.priority = 10; });
in
{
  environment.systemPackages = [
    discord-low
    pkgs.firejail
    discordScript
  ];
  programs.firejail.enable = true;
  #This produces a broken script - It puts a random `--` in the middle of the script which firejail
  #more or less goes "wtf" at. Above script works fine.

  #programs.firejail.wrappedBinaries = {
  #  Discord = {
  #     executable = "${pkgs.discord}/bin/discord";
  #      profile = ./discord.profile;
  #  };
  #};
}
