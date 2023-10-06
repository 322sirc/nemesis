{
  pkgs,
  config,
  ...
}:


 {
 
  home.pointerCursor = {
    name = "Catppuccin-Frappe-Maroon-Cursors";
    package = pkgs.catppuccin-cursors.frappeMaroon;
    gtk.enable = true;
    x11.enable = true;
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
  gtk.gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';

   gtk.gtk3.extraConfig = {
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
    gtk-xft-rgba = "rgb";
        
      };

   gtk.gtk4.extraConfig = {
    gtk-enable-animations = true;
    gtk-primary-button-warps-slider=false;
        
      };
    
  
#Qt theming
qt.platformTheme = "kde";
qt.style.name = "kvantum";

home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
     accent = "Maroon";
      variant = "Frappe";
    })
  ];

  home.sessionVariables =  {
   XCURSOR_SIZE = "24";
   QT_STYLE_OVERRIDE = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Frappe-Maroon
  '';

}
