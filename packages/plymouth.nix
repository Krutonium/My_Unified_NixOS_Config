{ config, pkgs, pkgs-unstable, ... }:
let
  aperture_files = builtins.fetchurl {
    url = "https://github.com/irth/plymouth-theme-aperture/archive/refs/heads/master.zip";
    sha256 = "09nizxxwbcjjw52sx7yldq14llf9g96n6zqb8ijg4r257rpawmv1";
  };

  aperture_plymouth_file =
    ''
    [Plymouth Theme]
    Name=Aperture Science
    Description=This is an Aperture Science theme for Plymouth
    ModuleName=script

    [script]
    ImageDir=${aperture-plymouth}/aperture
    ScriptFile=${aperture-plymouth}/aperture/aperture.script
    '';

  aperture-plymouth = pkgs.stdenv.mkDerivation {
    name = "aperture-plymouth";
    buildInputs = [pkgs.unzip];
    src = aperture_files;
    buildCommand = ''
      outDir="$out/share/plymouth/themes/"
      mkdir -p $outDir
      unzip $src -d $outDir
      mv $outDir/plymouth-theme-aperture-master $outDir/aperture
      # cat $outDir/aperture/aperture.plymouth | sed "s@/usr/@$out/@" > $outDir/aperture/aperture.plymouth
      rm $outDir/aperture/aperture.plymouth
      echo ${aperture_plymouth_file} > $outDir/aperture/aperture.plymouth
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
