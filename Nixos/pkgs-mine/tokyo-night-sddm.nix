 { lib, fetchFromGitHub }:

 let
 pname = "tokyo-night-sddm";

 in


  fetchFromGitHub {

    name = "${pname}";
    owner = "rototrash";
    repo = "tokyo-night-sddm";
    rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
    sha256 = "sha256-ZAonWb1xMZ0UC4BbJW21BhY++TYf0Rt3kNCCzW3pt/s=";
  

  postFetch = ''
    mv $out ./all
    mkdir -p $out/share/sddm/themes/tokyo-night-sddm 
    cp -ra ./all/* $out/share/sddm/themes/tokyo-night-sddm/ 
    rm -r ./all
  '';
   
  
}
