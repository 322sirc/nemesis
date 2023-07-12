{ config, pkgs, ... }:
let
  hyprlandConfigPath = "${config.home.homeDirectory}/.config/hypr/hyprland.conf.back";
  hyprlandConfig = builtins.readFile hyprlandConfigPath;
in
{
  wayland.windowManager.hyprland.extraConfig = ''
    ${hyprlandConfig}
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    env = QT_QPA_PLATFORMTHEME,qt5ct  #necessary to run qt5ct properly
    env = QT_QPA_PLATFORM,wayland;xcb
    env = GTK_THEME,Catppuccin-Frappe-Standard-Maroon-Dark
    env = GDK_DPI_SCALE,1.2
    env = XCURSOR_SIZE,24
  '';
}