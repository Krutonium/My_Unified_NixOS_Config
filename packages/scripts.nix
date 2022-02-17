{ config, pkgs, ... }:
let
  update = pkgs.writeShellScriptBin "update" ''
    echo Updating Local System
    updatePackages
    cd /etc/nixos/
    colmena apply switch --apply-local
  '';
  updatePackages = pkgs.writeShellScriptBin "updateConfig"''
    echo Updating Commit File...
    cd /etc/nixos/
    nix flake update --commit-lock-file
  '';
  updateAll = pkgs.writeShellScriptBin "updateAll" ''
    echo Updating All Systems
    updatePackages
    cd /etc/nixos/
    colmena apply switch --no-substitutes
  '';
  resetConfig = pkgs.writeShellScriptBin "resetConfig" ''
    cd ~
    rm -rf /home/krutonium/My_Unified_NixOS_Config
    git clone gitea@gitea.krutonium.ca:Krutonium/My_Unified_NixOS_Config.git /home/krutonium/My_Unified_NixOS_Config
    cd /home/krutonium/My_Unified_NixOS_Config/scripts
    ./relink.sh
    ./set_upstream.sh
    echo "Done"
  '';
  pushConfig = pkgs.writeShellScriptBin "pushConfig" ''
    cd /home/krutonium/My_Unified_NixOS_Config/
    git add .
    git commit -m "Update"
    git push
  '';
in
{
  environment.systemPackages = [ update updatePackages updateAll resetConfig pushConfig ];
}
