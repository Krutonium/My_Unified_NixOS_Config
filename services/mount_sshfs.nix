{ config, pkgs, ... }:
{
  fileSystems."/home/krutonium/share" =
    {
      device = "192.168.0.10:/home/krutonium/share";
      fsType = "sshfs";
      options =  [ "allow_other" "IdentityFile=/home/krutonium/.ssh/id_ed25519" ];
    };
}