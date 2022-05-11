# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      cursor-theme = "Bibata-Modern-DarkRed";
      document-font-name = "Ubuntu 11";
      font-antialiasing = "rgba";
      font-hinting = "full";
      font-name = "Ubuntu 11";
      gtk-theme = "WhiteSur-dark-solid";
      icon-theme = "WhiteSur-dark";
      monospace-font-name = "Ubuntu Mono 10";
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      titlebar-font = "Ubuntu 11";
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      overlay-key = "Super_L";
      workspaces-only-on-primary = true;
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "arcmenu@arcmenu.com" "dash-to-panel@jderose9.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "org.gnome.Nautilus.desktop" "firefox.desktop" "org.gnome.Console.desktop" ];
    };

    "org/gnome/shell/extensions/arcmenu" = {
      menu-button-appearance = "Icon";
      pinned-app-list = [ "Firefox (Wayland)" "" "firefox.desktop" "Files" "" "org.gnome.Nautilus.desktop" "Terminal" "" "org.gnome.Terminal.desktop" "ArcMenu Settings" "ArcMenu_ArcMenuIcon" "gnome-extensions prefs arcmenu@arcmenu.com" ];
      prefs-visible-page = 0;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      appicon-margin = 8;
      appicon-padding = 4;
      available-monitors = [ 0 1 2 ];
      group-apps = false;
      group-apps-label-font-size = 14;
      group-apps-label-max-width = 0;
      group-apps-use-launchers = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = -1;
      panel-anchors = "'{"0":"MIDDLE","1":"MIDDLE","2":"MIDDLE"}'";
      panel-element-positions = "'{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"2":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'";
      panel-lengths = "'{"0":100,"1":100,"2":100}'";
      panel-sizes = "'{"0":48,"1":48,"2":48}'";
      show-appmenu = false;
      status-icon-padding = -1;
      tray-padding = -1;
      window-preview-title-position = "TOP";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-dark-solid";
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
    };

  };
}