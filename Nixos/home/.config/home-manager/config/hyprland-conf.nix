{ config, pkgs, ... }:
let
  hyprlandConfigPath = "${config.home.homeDirectory}/.config/hypr/hyprland.conf";
  hyprlandConfig = builtins.readFile hyprlandConfigPath;
in
{
  wayland.windowManager.hyprland.extraConfig = ''
    ${hyprlandConfig}
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=/nix/store/hg62hq7ycqaw25sxzyd2ib4i27q9xhhq-polkit-kde-agent-1-5.27.6/libexec/polkit-kde-authentication-agent-1
  '';
}