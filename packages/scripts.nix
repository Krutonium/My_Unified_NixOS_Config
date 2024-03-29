{ config, pkgs, ... }:
let
  RepoPath = "/home/krutonium/NixOS";
  RepoURL = "gitea@gitea.krutonium.ca:Krutonium/My_Unified_NixOS_Config.git";

  update = pkgs.writeShellScriptBin "update" ''
    cd "${RepoPath}"
    deploy-cs
  '';

  buildISO = pkgs.writeShellScriptBin "buildISO" ''
    nix build ${RepoPath}#nixosConfigurations.isoImage.config.system.build.isoImage
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
    NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs#$@ --impure
  '';
  dualcomma = pkgs.writeShellScriptBin ",," ''
    echo "Loading..."
    nix-shell -p $@
  '';

  # For generating stickers for Telegram
  mkSticker = pkgs.writeShellScriptBin "mkSticker" ''
    ffmpeg -i $1 -vf 'scale=if(gte(a\,512/512)\,min(512\,iw)\,-2):if(gte(a\,512/512)\,-2\,min(512\,ih))' $2
  '';

  search = pkgs.writeShellScriptBin "search" ''
    nix search nixpkgs $@
  '';

  buildIso = pkgs.writeShellScriptBin "buildIso" ''
    cd ${RepoPath}
    nix build .#nixosConfigurations.isoImage.config.system.build.isoImage
    echo $PWD/result
  '';
in
{
  environment.systemPackages = [ update resetConfig linkRepo setUpstream pushConfig comma dualcomma buildISO mkSticker search buildIso ];
}
