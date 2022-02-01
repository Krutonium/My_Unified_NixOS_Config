{ config, ... }:
{
  boot.kernelParams = [ "mitigations=off" ];
}
