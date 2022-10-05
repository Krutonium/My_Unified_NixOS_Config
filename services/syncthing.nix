{ pkgs, config, ...}:
{
  services.syncthing = {
    enable = true;
    user = "krutonium";     
    folders = {
      "/home/krutonium/share" = {
        id = "homeshare";
    };
  };
}
