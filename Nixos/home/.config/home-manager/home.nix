{ config, pkgs, libs, ... }:

{
    imports = [
    ./config/theme.nix
    ./config/hyprland-conf.nix
    ./config/waybar-conf.nix
    ./config/wlogout.nix
    ./packages.nix
    ./hyprland-upd.nix
    
    
    
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cris";
  home.homeDirectory = "/home/cris";
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    SUBLIME_TEXT_USE_POLKIT = "1";
    MOZ_ENABLE_WAYLAND=1;
  };
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  #home.enableNixpkgsReleaseCheck = false;
  # The home.packages option allows you to install Nix packages into your
  # environment.

  
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  #home.file.".config/alacritty/alacritty.yml" = {
  #  source = /$HOME/.config/alacritty/alacritty.yml;
  #};

home.file = {
  "waybar" = {
   source = /home/cris/.config/hypr/waybar;
   recursive = true;
   };
   
   
};   
programs.waybar.enable = true;
  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cris/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
#services.xserver.displayManager.sddm.theme = "catppuccin-frappe";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
    patches = (oa.patches or []) ++ [
      (pkgs.fetchpatch {
        name = "fix waybar hyprctl";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
        sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
      })
    ];
  });
  

 
    

}