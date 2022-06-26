{config, pkgs, ...}:
{
  nixpkgs.overlays = [ (self: super: {mesa = super.mesa.override { galliumDrivers  = [ "auto" "zink" "r600" "swrast" ]; }; } ) ];
}