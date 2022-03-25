{config, pkgs, fetchurl, autoPatchelfHook, ...}:
let
  godot-mono-file = builtins.fetchurl {
    url = "https://github.com/godotengine/godot/releases/download/3.4.4-stable/Godot_v3.4.4-stable_mono_x11_64.zip";
    sha256 = "0xm7skja7l1c9hrz29krqfyxg9am1pik873qz7qzqw5bnmcjhqpc";
  };

  godot-mono = pkgs.stdenv.mkDerivation {
    name = "godot-mono";
    buildInputs = [pkgs.unzip];
    src = godot-mono-file;
    nativeBuildInputs = [
      pkgs.autoPatchelfHook
    ];
    buildCommand = ''
      outDir="$out/bin/godotsharp/"
      mkdir -p $outDir
      unzip $src -d $outDir
    '';
  };
in
{
  home.packages = [
    godot-mono
  ];
  home.file."godot-mono".source = pkgs.godot-mono;
}