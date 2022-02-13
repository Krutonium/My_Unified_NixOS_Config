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
  rebootEverything = pkgss.writeShellScriptBin "rebootEverything" ''
    ssh root@uwebserver 'shutdown -r 10s' &
    ssh root@umsilaptop 'shutdown -r 10s' &
    ssh root@uhplaptop 'shutdown -r 10s' &
    ssh root@ugamingpc 'shutdown -r 10s'
    echo "Done"
  '';
  rebootCancel = pkgss.writeShellScriptBin "rebootCancel" ''
    ssh root@uwebserver 'shutdown -c' &
    ssh root@umsilaptop 'shutdown -c' &
    ssh root@uhplaptop 'shutdown -c' &
    ssh root@ugamingpc 'shutdown -c'
    echo "Done"
  '';
in {
  environment.systemPackages = [ update updateAll resetConfig pushConfig rebootEverything rebootCancel ];
}