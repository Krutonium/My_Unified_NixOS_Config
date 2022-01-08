{ config, pkgs, ... }:
{
    environment.systemPackages = [ pkgs.gcc11 pkgs.ccache ];
}
