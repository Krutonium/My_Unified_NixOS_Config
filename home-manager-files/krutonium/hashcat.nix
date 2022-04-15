{ pkgs }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "hashcat-env";
    targetPkgs = pkgs: with pkgs; [
      git
      gitRepo
      gnupg
      autoconf
      curl
      procps
      gnumake
      utillinux
      m4
      gperf
      unzip
      cudatoolkit
      hardware.nvidia.package
      libGLU libGL
      xorg.libXi xorg.libXmu freeglut
      xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
      ncurses5
      stdenv.cc
      binutils
      hashcat
      hashcat-utils
    ];
    multiPkgs = pkgs: with pkgs; [ zlib ];
    runScript = "bash";
    profile = ''
       export CUDA_PATH=${pkgs.cudatoolkit}
       # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib
       export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
       export EXTRA_CCFLAGS="-I/usr/include"
     '';
  };
in
pkgs.stdenv.mkDerivation {
   name = "hashcat-env-shell";
   nativeBuildInputs = [ fhs ];
   shellHook = "exec hashcat-env";
}