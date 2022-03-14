{ config, pkgs, pkgs-unstable, ... }:
let
  aperture_files = builtins.fetchurl {
    url = "https://github.com/irth/plymouth-theme-aperture/archive/refs/heads/master.zip";
    sha256 = "09nizxxwbcjjw52sx7yldq14llf9g96n6zqb8ijg4r257rpawmv1";
  };

  aperture-plymouth = pkgs.stdenv.mkDerivation {
    name = "aperture-plymouth";
    buildInputs = [pkgs.unzip pkgs.moreutils];
    src = aperture_files;
    buildCommand = ''
      outDir="$out/share/plymouth/themes/"
      mkdir -p $outDir
      unzip $src -d $outDir
      mv $outDir/plymouth-theme-aperture-master $outDir/aperture
      sed "s%/usr/share%$outdir%g" $outDir/aperture/aperture.plymouth | sponge $outDir/aperture/aperture.plymouth
      cat $outDir/aperture/aperture.plymouth

    '';
  };
in
{
  environment.systemPackages = [
    pkgs-unstable.plymouth
  ];

  boot.plymouth.enable = true;
  boot.plymouth.theme = "aperture";
  boot.plymouth.themePackages = [
    aperture-plymouth
  ];
}
