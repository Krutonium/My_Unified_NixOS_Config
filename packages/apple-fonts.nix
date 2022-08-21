{config, pkgs, fetchzip, ...}:
let
  fontFiles = pkgs.fetchzip {
    url = "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip";
    sha256 = "sha256-ZsDMSpMvl9m8dtUlQzDREe3IozC0j/iRLWoUWXfXfNo=";
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