{ stdenv
, lib
, fetchFromGitHub
, glib
, gtk3
, pkgs
}:

let
  srcs = import ./srcs.nix { inherit fetchFromGitHub; };
in
stdenv.mkDerivation rec {
  pname = "nemo-compare";
  inherit (srcs) version src;
  inherit (pkgs) cinnamon.nemo-with-extensions meld;

  sourceRoot = "${src.name}/nemo-compare";
  
  
  buildInputs = [
    glib
    gtk3
    nemo
    meld
  ];

  postPatch = ''
    substituteInPlace setup.py \ 
          --replace "/usr/share" "share"
    substituteInPlace src/nemo-compare-preferances \
      --replace "/usr/share" "$out/share"
    substituteInPlace src/nemo-compare.py \
      --replace "/usr/share" "$out/share"
    substituteInPlace src/utility.py \
      --replace '/usr/bin' '$out/bin'
      --replace '/usr/local/bin' '$out/local/bin'
  '';

preFixup = ''
    
    makeWrapper $out/bin/nemo-compare \
      --prefix PATH : "${nemo}/bin"

    '';

  installPhase = ''
  mkdir -p $out/share/nemo-python/extensions/
  cp -r src/nemo-compare.py $out/share/nemo-python/extensions/
  cp -r src/nemo-compare-preferences.py src/utils.py $out/share/nemo-compare/
  cp -r src/nemo-compare-preferences $out/bin/
'';
}