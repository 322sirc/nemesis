{ config, pkgs, libs, system, hyprland, ... }:

{
    imports = [
    ./config/foot.nix
    ./config/theme.nix
    ./config/hyprland-conf.nix
    #./config/waybar-conf.nix
    ./config/wlogout.nix
    ./packages.nix
    ./hyprland-upd.nix
    #./pkgs/spectrum-icons.nix
    
    
    
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
    #if your cursor become invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    #hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
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

nixpkgs.overlays = [                                      # Waybar needs to be compiled with the experimental flag for wlr/workspaces to work (for now done with hyprland.nix)
    (self: super: {
       waybar = super.waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
         patchPhase = ''
           substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
         '';
       });
    
       
     })


   ];

   
 
 }