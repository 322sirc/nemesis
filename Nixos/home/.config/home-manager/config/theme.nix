{
  pkgs,
  config,
  ...
}:


 {
 
  home.pointerCursor = {
    name = "Catppuccin-Frappe-Maroon-Cursors";
    package = pkgs.catppuccin-cursors.frappeMaroon;
    size = 24;    
     
    };

#GTK theming
   gtk = {
    enable = true;
    font = {
      name = "Helvetica Now Display SemiLight 11";
    };
    
    cursorTheme = {
      name = "Catppuccin-Frappe-Maroon-Cursors";
      package = pkgs.catppuccin-cursors.frappeMaroon;
      size = 24;
    };

    iconTheme = {
      name = "Fluent-red";
      package = pkgs.fluent-icon-theme.override {
       colorVariants = ["red"];
       };
    };

    theme = {
      name = "Catppuccin-Frappe-Standard-Maroon-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["maroon"];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "frappe";
        
      };
    };
  };

   gtk.gtk3.extraConfig = {
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintmedium";
        
      };

   gtk.gtk4.extraConfig = {
    gtk-enable-animations = true;
    gtk-primary-button-warps-slider=false;
        
      };
    
  
#Qt theming
home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
     accent = "Maroon";
      variant = "Frappe";
    })
  ];
  #home.sessionVariables = lib.mkForce {
   # QT_STYLE_OVERRIDE = "Catppuccin-Frappe-Maroon";
  #};

  #xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
  #  General.Theme = "Catppuccin-Frappe-Maroon";
  #}; 

}
