{ lib, fetchFromGitHub }:

 let
 pname = "font-helveticanow";

 in


  fetchFromGitHub {

    name = "HelveticaNow";
    owner = "impostersussy";
    repo = "HelveticaNow";
    rev = "e9a76972d1cdf0ad67266bc9443a3e7437c1eead";
    sha256 = "sha256-ltwOnCzLUZ6idr3MIUQ9eEZy8LOs4hyX32ZpICraCu4=";
  

  postFetch = ''
    mv $out ./all
    mkdir -p $out/share/fonts/opentype/ 
    cp ./all/Display/otf/* $out/share/fonts/opentype/ 
    rm -r ./all
  '';
   
  
}