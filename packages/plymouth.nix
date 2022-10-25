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

  # Windows 95 Boot Screen
  win95_files = builtins.fetchurl {
    url = "https://gitea.krutonium.ca/Krutonium/NixOS_Files/raw/branch/master/Chicago95.zip";
    sha256 = "095i1nrmc9ldvq869jl80p04njd52qvl0cbkgchi2sjlg27cdvrf";
  };

  win95-plymouth = pkgs.stdenv.mkDerivation {
    name = "win95-plymouth";
    buildInputs = [ pkgs.unzip pkgs.moreutils ];
    src = win95_files;
    buildCommand = ''
      outDir="$out/share/plymouth/themes/"
      mkdir -p $outDir/Chicago95
      unzip $src -d $outDir/Chicago95
      sed "s%/usr/share/plymouth/themes/%$outDir%g" $outDir/Chicago95/Chicago95.plymouth | sponge $outDir/Chicago95/Chicago95.plymouth
    '';
  };

  # Windows XP Boot Screen
  xp_files = builtins.fetchurl {
    url = "https://gitea.krutonium.ca/Krutonium/NixOS_Files/raw/branch/master/WindozeXP.zip";
    sha256 = "";
  };

  xp-plymouth = pkgs.stdenv.mkDerivation {
    name = "xp-plymouth";
    buildInputs = [ pkgs.unzip pkgs.moreutils ];
    src = xp_files;
    buildCommand = ''
      outDir="$out/share/plymouth/themes/"
      mkdir -p $outDir/WindozeXP
      unzip $src -d $outDir/WindozeXP
      sed "s%/usr/share/plymouth/themes/%$outDir%g" $outDir/WindozeXP/WindozeXP.plymouth | sponge $outDir/WindozeXP/WindozeXP.plymouth
    '';
  };
in
{
  environment.systemPackages = [
    pkgs.plymouth
  ];

  boot.plymouth.enable = true;
  #boot.plymouth.theme = "aperture";
  #boot.plymouth.theme = "Chicago95";
  boot.plymouth.theme = "WindozeXP";
  boot.plymouth.themePackages = [
    #aperture-plymouth
    #win95-plymouth
    xp-plymouth
  ];
}
