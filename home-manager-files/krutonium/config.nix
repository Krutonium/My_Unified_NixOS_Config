{ config, pkgs, ... }:
{
  home.file = {
    ".nanorc".text = ''
      set linenumbers
      set autoindent
      set historylog
      set softwrap
      set tabstospaces
    '';
    ".config/discord/settings.json".text = ''
      {
        "BACKGROUND_COLOR": "#202225",
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": false,
        "SKIP_HOST_UPDATE: false",
        "WINDOW_BOUNDS": {
          "x": 307,
          "y" = 127,
          "width" = 1280,
          "height" = 725
        }
      }
    '';
  };
}
