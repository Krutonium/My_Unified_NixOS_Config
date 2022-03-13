{ configs, pkgs-unstable, ...}:
{
  envionment.systemPackages = {
    pkgs-unstable.cinny
  }
}