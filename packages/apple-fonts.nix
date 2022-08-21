{config, pkgs, fetchzip, ...}:
let
  fontFiles = builtins.fetchzip {
    url = "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip";
    sha256 = "";
    stripRoot = false;
  };
  fonts = pkgs.stdenv.mkDerivation {
    name = "Apple Fonts";
    src = fontFiles;
    buildInputs = [ ];
    buildCommand =
    ''
       mkdir -p $out/share/fonts
       cp -R $src $out/share/fonts/opentype/
    '';
  };
in
{
  fonts.fonts = [ fonts ];
}