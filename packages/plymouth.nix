{ config, pkgs, ... }:
let
  aperture_files = builtins.fetchurl {
    url = "https://github.com/irth/plymouth-theme-aperture/archive/refs/heads/master.zip";
    sha256 = "09nizxxwbcjjw52sx7yldq14llf9g96n6zqb8ijg4r257rpawmv1";
  };

  aperture-plymouth = pkgs.stdenv.mkDerivation {
    name = "aperture-plymouth";
    buildInputs = [ pkgs.unzip pkgs.moreutils ];
    src = aperture_files;
    buildCommand = ''
      outDir="$out/share/plymouth/themes/"
      mkdir -p $outDir
      unzip $src -d $outDir
      mv $outDir/plymouth-theme-aperture-master $outDir/aperture
      sed "s%/usr/share/plymouth/themes/%$outDir%g" $outDir/aperture/aperture.plymouth | sponge $outDir/aperture/aperture.plymouth
      # Apparently using cat and sed breaks? I don't know why. So we summon an eldritch force to do it for us.
    '';
  };
in
{
  environment.systemPackages = [
    pkgs.plymouth
  ];

  boot.plymouth.enable = true;
  boot.plymouth.theme = "aperture";
  boot.plymouth.themePackages = [
    aperture-plymouth
  ];
}
