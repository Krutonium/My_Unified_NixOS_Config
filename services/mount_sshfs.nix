{ config, pkgs, ... }:
{
  fileSystems."/home/krutonium/share" =
    {
      device = "192.168.0.10:/share";
      fsType = "sshfs";
      options =  [ "-o allow_other -o IdentityFile=/home/krutonium/.ssh/id_ed25519" ];
    };
}