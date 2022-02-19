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
  };
}
