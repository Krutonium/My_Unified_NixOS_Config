{config, pkgs, ...}:
let
  candy-icons = pkgs.stdenv.mkDerivation {
    name = "candy-icons";
    buildInputs = [pkgs.unzip];
    src = builtins.fetchurl https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip;
    buildCommand = ''
      outDir="$out/share/icons/"
      iconDir="$outDir/candy-icons/apps/scalable/"
      mkdir -p $outDir
      unzip $src -d $outDir
      mv $outDir/candy-icons-master $outDir/candy-icons
      cp $iconDir/minecraft.svg $iconDir/org.polymc.PolyMC.svg
    '';
  };
in
{
  environment.systemPackages = [
    candy-icons
  ];
}