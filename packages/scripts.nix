{ config, pkgs, ... }:
let
  update = pkgs.writeShellScriptBin "update" ''
    echo Updating Local System
    updateConfig
    cd /etc/nixos/
    sudo colmena apply-local switch
  '';
  updatePackages = pkgs.writeShellScriptBin "updateConfig"''
    echo Updating Commit File...
    cd /etc/nixos/
    nix flake update --commit-lock-file
  '';
  updateAll = pkgs.writeShellScriptBin "updateAll" ''
    echo Updating All Systems
    updateConfig
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
  comma = pkgs.writeShellScriptBin "," ''
    echo "Loading..."
    nix shell nixpkgs#$@
  '';
  dualcomma = pkgs.writeShellScriptBin ",," ''
    echo "Loading..."
    nix-shell -p $@
  '';
in
{
  environment.systemPackages = [ update updatePackages updateAll resetConfig pushConfig comma dualcomma ];
}
