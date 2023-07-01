{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs;[
    
    btop
    htop
    firefox-wayland
    tree
    catppuccin-kvantum
    gnome.gnome-logs
    libnotify
    notify-desktop
    pamixer
    pavucontrol
    tuner
    zip
    unzip
    unrar
    waybar
    wlroots
    xwayland

    ];
}
