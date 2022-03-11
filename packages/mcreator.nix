{pkgs, configs, fetchurl, stdenv, ...}:
let
  file = fetchurl {
    #sha256 = "sha256-XsAXHyabtDgPhSamjwjAhMqnY2Fzlip9ABDc1FsWkvc=";
    url = "https://github.com/MCreator/MCreator/releases/download/2021.3.54000/MCreator.2021.3.Linux.64bit.tar.gz";
  };
  mcreator = stdenv.mkDerivation {
    name = "mcreator";
    buildInputs = [];
    src = file;
    buildCommand = ''
      outDir="$out/bin/"
      workDir = "$outDir/MCreator20213/"
      mkdir -p $outDir
      tar -xvf $src --directory $outDir
      rm -rd $workDir/jdk
    '';
  };

in
{
  environment.systemPackages = [
    mcreator
  ];
}