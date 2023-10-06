{ pkgs, libs, ... }:

pkgs.stdenv.mkDerivation {
	name = "spectrum-icons";

	src = pkgs.fetchFromGitHub {
       owner = "L4ki";
       repo = "Spectrum-Color-Icons";
       rev = "4c63257f3310a860151ae0045b35ffc8190910e0";
       sha256 = "1amfr8m0ykjr1asf58mckbq02rqzrwaxrdqhxr1fb9gwc1mpfzx8";
	};

	installPhase = ''
	mkdir -p $out/share/icons
	cp -r ./Spectrum-Color-Dark-Icons $out/share/icons/

	'';
}