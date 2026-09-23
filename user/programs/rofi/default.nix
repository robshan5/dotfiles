{ pkgs, vars, ... }:
let
  c = vars.theme.colors;
  f = vars.theme.fonts;
  o = vars.theme.opacity;

  # The rounded theme splits colours from layout; only the colours are generated.
  colorsRasi = pkgs.writeText "theme.rasi" ''
    * {
        bg0:    ${c.background}${o.panel};
        bg1:    ${c.surface}${o.input};
        bg2:    ${c.selection}${o.row};
        bg3:    ${c.accent}${o.panel};
        fg0:    ${c.foreground};
        fg1:    ${c.brightWhite};
        fg2:    ${c.comment};
        fg3:    ${c.overlay};
    }

    @import "rounded-common.rasi"

    /* after the import, otherwise the common theme's own font wins */
    * {
        font:   "${f.mono} ${toString f.sizeMenu}";
    }
  '';

  # rounded-common.rasi is imported by relative path, so both files need to sit together.
  rofiTheme = pkgs.runCommand "rofi-theme" { } ''
    mkdir -p $out
    cp ${./themes/rounded-common.rasi} $out/rounded-common.rasi
    cp ${colorsRasi} $out/theme.rasi
  '';
in
{
  programs.rofi = {
    enable = true;
    font = "${f.mono} ${toString f.sizeMenu}";
    theme = "${rofiTheme}/theme.rasi";
  };
}
