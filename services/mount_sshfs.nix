{ config, pkgs, ... }:
{
  fileSystems."/home/krutonium/share" =
    {
      device = "krutonium.ca:/home/krutonium/share";
      fsType = "sshfs";
      options =  [ "allow_other" "IdentityFile=/home/krutonium/.ssh/id_ed25519" ];
    };
}
