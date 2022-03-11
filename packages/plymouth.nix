{ config, pkgs, pkgs-unstable, ... }:
let
  aperture-plymouth = pkgs.stdenv.mkDerivation {
    name = "aperture-plymouth";
    buildInputs = [pkgs.unzip];
    src = builtins.fetchurl https://github.com/irth/plymouth-theme-aperture/archive/refs/heads/master.zip;
    buildCommand = ''
      outDir="$out/share/plymouth/themes/"
      mkdir -p $outDir
      unzip $src -d $outDir
      mv $outDir/plymouth-theme-aperture-master $outDir/aperture
      cat $outDir/aperture/aperture.plymouth | sed  "s@\/usr\/@$out\/@" > $outDir/aperture/aperture.plymouth
    '';
  };
in
{
  environment.systemPackages = [
    pkgs-unstable.plymouth
  ];

  boot.plymouth.enable = true;
  #boot.plymouth.theme = "aperture";
  boot.plymouth.themePackages = [
    aperture-plymouth
  ];
}
