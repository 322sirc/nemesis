{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs;[
    
    btop
    discord
    htop
    firefox-wayland
    tree
    catppuccin-kvantum
    gnome.gnome-logs
    libnotify
    notify-desktop
    pamixer
    pavucontrol
    swayimg
    tuner
    zip
    unzip
    unrar
    waybar
    wlroots
    xwayland

    ];
}
