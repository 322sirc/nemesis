{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1w"
              ];

  home.packages = with pkgs;[

  
    
    btop
    discord
    eza
    fop
    htop
    firefox-wayland
    tree
    catppuccin-kvantum
    gnome.gnome-logs
    guvcview
    inkscape
    kitty
    libbsd
    libdecor
    libnotify
    libxslt
    libsForQt5.kcalc
    nettle
    notify-desktop
    pamixer
    pavucontrol
    sublime4
    swayimg
    systemd
    tuner
    zip
    unzip
    unrar
    vlc
    waybar
    wayland
    wlroots
    xwayland
    xmlto
    xorg.xorgproto
    youtube-music

    ];
}
