{config, pkgs, fetchzip, ...}:
let
  fontFiles = pkgs.fetchzip {
    url = "https://gitea.krutonium.ca/Krutonium/NixOS_Files/raw/branch/master/Fonts.zip";
    sha256 = "sha256-44KDjOw0/pGWIeD3o2V2WJJl7rScq8OftmfC549FhGA=";
    stripRoot = false;
  };
  fonts = pkgs.stdenv.mkDerivation {
    name = "Additional Fonts";
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