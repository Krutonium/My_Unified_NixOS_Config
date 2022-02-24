{ config, pkgs, ... }:
let
  RepoPath = "/home/krutonium/NixOS";
  RepoURL = "gitea@gitea.krutonium.ca:Krutonium/My_Unified_NixOS_Config.git";

  update = pkgs.writeShellScriptBin "update" ''
    echo Updating Local System
    pullConfig
    cd ${RepoPath}
    sudo colmena apply-local switch
    rm flake.lock
  '';
  updatePackages = pkgs.writeShellScriptBin "pullConfig"''
    echo Updating Commit File...
    cd ${RepoPath}
    git pull
    nix flake update
  '';
  updateAll = pkgs.writeShellScriptBin "updateAll" ''
    echo Updating All Systems
    pullConfig
    cd ${RepoPath}
    colmena apply switch --no-substitutes
    rm flake.lock
  '';
  resetConfig = pkgs.writeShellScriptBin "resetConfig" ''
    cd ~
    rm -rf ${RepoPath}
    git clone ${RepoURL} ${RepoPath}
    cd ${RepoPath}
    linkRepo
    setUpstream
    echo "Done"
  '';
  linkRepo = pkgs.writeShellScriptBin "linkRepo" ''
    if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root" 1>&2
        exec sudo "$0" "$@"
    fi
    rm /etc/nixos
    cd ${RepoPath}
    ln -s ${RepoPath} /etc/nixos
  '';
  setUpstream = pkgs.writeShellScriptBin "setUpstream" ''
    cd ${RepoPath}
    git remote set-url --add --push origin git@github.com:Krutonium/My_Unified_NixOS_Config.git
    git remote set-url --add --push origin gitea@gitea.krutonium.ca:Krutonium/My_Unified_NixOS_Config.git
  '';
  pushConfig = pkgs.writeShellScriptBin "pushConfig" ''
    cd ${RepoPath}
    git add .
    git commit
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
  environment.systemPackages = [ update updatePackages updateAll resetConfig linkRepo setUpstream pushConfig comma dualcomma ];
}
