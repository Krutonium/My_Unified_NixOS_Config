{config, pkgs, ...}:
let
  update = pkgs.writeShellScriptBin "update" ''
    cd /etc/nixos/
    git pull
    nix flake update --commit-lock-file
    colmena apply switch --no-substitutes --on $(hostname)
  '';
  updateAll = pkgs.writeShellScriptBin "updateAll" ''
    cd /etc/nixos/
    git pull
    nix flake update --commit-lock-file
    colmena apply switch --no-substitutes
  '';
  resetConfig = pkgs.writeShellScriptBin "resetConfig" ''
    rm -rf /home/krutonium/My_Unified_NixOS_Config
    git clone gitea@gitea.krutonium.ca:Krutonium/My_Unified_NixOS_Config.git /home/krutonium/My_Unified_NixOS_Config
    cd /home/krutonium/My_Unified_NixOS_Config/scripts
    ./relink.sh
    ./set_upstream.sh
    echo "Done"
  '';


in {
  environment.systemPackages = [ update updateAll resetConfig ];
}