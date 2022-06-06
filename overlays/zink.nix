#pkgs.mesa = mesa.override { galliumDrivers = [ "auto" "zink" "r600" "swrast" ];
self: super: {mesa = super.mesa.override { galliumDrivers  = [ "auto" "zink" "r600" "swrast" ]; }; }