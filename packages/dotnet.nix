{ config, pkgs, ... }:
{
  environment.systemPackages = [
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_5_0
      sdk_6_0
    ])
  ];
}
