{
  pkgs,
  config,
  lib,
  ...
}:
# manage files in ~
{
  imports = [
    ./config/wlogout.nix
    ./config/waybar-conf.nix
  ];

  home.file.".config" = {
    source = ./config;
    recursive = true;
  };

  }
