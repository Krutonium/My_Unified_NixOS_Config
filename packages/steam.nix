{ config, pkgs, ... }:
let
  steamScript = pkgs.writeShellScriptBin "steam"
    ''
      mangohud --dlsym ${pkgs.steam}/bin/steam
    '';
  lowSteam = pkgs.steam.overrideAttrs (oldAttrs: { meta.priority = 10; });

  #What have we learned today? Basically, this doesn't work. It ends up making Steam either not start at all, or start with a blank screen.
in
{

  # Gotta have good old steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  environment.systemPackages = [
    #steamScript
    lowSteam
  ];

}
