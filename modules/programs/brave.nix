{
  pkgs,
  lib,
  ...
}:
{
  # Ensure Brave browser package installed
  home.packages = [ pkgs.brave ];
}
