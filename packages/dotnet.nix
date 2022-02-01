{ config, pkgs, ... }:
{
  environment.systemPackages = [
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_3_1
      sdk_5_0
      sdk_6_0
    ])
  ];
}
