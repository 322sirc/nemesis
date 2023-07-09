 { lib, fetchFromGitHub }:

 let
 pname = "catppuccin-sddm";

 in


  fetchFromGitHub {

    name = "${pname}";
    owner = "catppuccin";
    repo = "sddm";
    rev = "bde6932e1ae0f8fdda76eff5c81ea8d3b7d653c0";
    sha256 = "sha256-Y/lNbPyiBuPVc1yYzlPmF2Ti8QI63HtRKo8OO7YdiNU=";
  

  postFetch = ''
    mv $out ./all
    mkdir -p $out/share/sddm/themes/catppuccin-frappe 
    cp -ra ./all/src/catppuccin-frappe/* $out/share/sddm/themes/catppuccin-frappe/ 
    rm -r ./all
  '';
   
  
}
