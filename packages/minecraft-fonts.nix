{config, pkgs, fetchzip, ...}:
let
  mcFont1 = pkgs.fetchzip {
    url = "https://github.com/IdreesInc/Minecraft-Font/archive/refs/heads/master.zip";
    sha256 = "sha256-ZsDMSpMvl9m8dtUlQzDREe3IozC0j/iRLWoUWXfXfNo=";
    stripRoot = false;
  };
  mcFont2 = pkgs.fetchzip {
    url = "https://github.com/IdreesInc/Monocraft/archive/refs/heads/master.zip";
    sha256 = "sha256-ZsDMSpMvl9m8dtUlQzDREe3IozC0j/iRLWoUWXfXfNo=";
    stripRoot = false;
  };

  MinecraftFont1 = pkgs.stdenv.mkDerivation {
    name = "Minecraft Font";
    src = mcFont1;
    buildInputs = [ ];
    buildCommand =
    ''
       mkdir -p $out/share/fonts
       cp -R $src/*.otf $out/share/fonts/opentype/
    '';
  };
  MinecraftFont2 = pkgs.stdenv.mkDerivation {
    name = "Minecraft Monospace Font";
    src = mcFont2;
    buildInputs = [ ];
    buildCommand =
    ''
       mkdir -p $out/share/fonts
       cp -R $src/*.otf $out/share/fonts/opentype/
    '';
  };
in
{
  fonts.fonts = [ MinecraftFont1 MinecraftFont2 ];
}