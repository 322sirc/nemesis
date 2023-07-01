{
  pkgs,
  config,
  ...
}:


 {
 #GTK theming
  home.pointerCursor = {
    name = "Catppuccin-Frappe-Maroon-Cursors";
    package = pkgs.catppuccin-cursors.frappeMaroon;
    size = 24;    
     
    };


   gtk = {
    enable = true;
    font = {
      name = "Helvetica Neue LT Std 35 Thin 12";
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
