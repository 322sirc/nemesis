self: super:
{
  home-manager = super.home-manager.override {
    overrides = oldAttrs: rec {
      overrides = oldAttrs.overrides // {
        waybar = super.waybar.overrideAttrs (oldWaybarAttrs: {
          mesonFlags = (oldWaybarAttrs.mesonFlags or []) ++ [ "-Dexperimental=true" ];
          patches = (oldWaybarAttrs.patches or []) ++ [
            (super.fetchpatch {
              name = "fix waybar hyprctl";
              url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
              sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
            })
          ];
        });
      };
    };
  };
}