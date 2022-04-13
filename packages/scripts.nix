{ config, pkgs, ... }:
let
  RepoPath = "/home/krutonium/NixOS";
  RepoURL = "gitea@gitea.krutonium.ca:Krutonium/My_Unified_NixOS_Config.git";

  update = pkgs.writeShellScriptBin "update" ''
    echo Updating Local System
    pushConfig
    pullConfig
    cd ${RepoPath}
    colmena apply --on $(hostname)
  '';
  updatePackages = pkgs.writeShellScriptBin "pullConfig" ''
    echo Updating Commit File...
    cd ${RepoPath}
    git pull
    nix flake update --commit-lock-file
    git push
  '';

  updateSpecific = pkgs.writeShellScriptBin "updateSpecific" ''
    echo Updating Specific System
    pushConfig
    pullConfig
    cd ${RepoPath}
    colmena apply --on $@
  '';

  updateAll = pkgs.writeShellScriptBin "updateAll" ''
    echo Updating All Systems
    pushConfig
    pullConfig
    cd ${RepoPath}
    colmena apply switch --no-substitutes
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
    git pull
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
  steamos = pkgs.writeShellScriptBin "steamos" ''
    steam -steamos3 -steamdeck -gamepadui
  '';
  steamos-update = pkgs.writeShellScriptBin "steamos-update" ''
    echo stub
  '';
in
{
  environment.systemPackages = [ update updatePackages updateAll resetConfig linkRepo setUpstream pushConfig comma dualcomma steamos steamos-update updateSpecific ];
}
