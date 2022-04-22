{ config, pkgs, fetchurl, ... }:
let
  icon_file = builtins.fetchurl {
    url = "https://github.com/EliverLara/candy-icons/archive/dfef69fa4f5348372b69378e4caeb02c8b719be7.zip";
    sha256 = "0i87rxrfqgqsldv45qppb9q720v1zd5mzclm7522srm5havbs4a5";
  };

  candy-icons = pkgs.stdenv.mkDerivation {
    name = "candy-icons";
    buildInputs = [ pkgs.unzip ];
    src = icon_file;
    buildCommand = ''
      outDir="$out/share/icons/"
      iconDir="$outDir/candy-icons/apps/scalable/"
      mkdir -p $outDir
      unzip $src -d $outDir
      mv $outDir/candy-icons-* $outDir/candy-icons
      cp $iconDir/minecraft.svg $iconDir/org.polymc.PolyMC.svg
    '';
  };
in
{
  environment.systemPackages = [
    candy-icons
  ];
}
