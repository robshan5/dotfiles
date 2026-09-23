{ vars, ... }:
let
  c = vars.theme.colors;
  f = vars.theme.fonts;
in
{
  imports = [
    ./starship.nix
  ];
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font = {
      name = f.mono;
      size = f.sizeTerminal;
    };

    # Palette comes from vars.theme instead of a bundled themeFile.
    settings = {
      background = c.background;
      foreground = c.foreground;
      cursor = c.cursor;
      cursor_text_color = c.background;
      selection_background = c.selection;
      selection_foreground = c.foreground;
      url_color = c.blue;

      active_tab_background = c.accent;
      active_tab_foreground = c.background;
      inactive_tab_background = c.surface;
      inactive_tab_foreground = c.comment;
      active_border_color = c.accent;
      inactive_border_color = c.overlay;

      color0 = c.black;
      color1 = c.red;
      color2 = c.green;
      color3 = c.yellow;
      color4 = c.blue;
      color5 = c.magenta;
      color6 = c.cyan;
      color7 = c.white;
      color8 = c.brightBlack;
      color9 = c.brightRed;
      color10 = c.brightGreen;
      color11 = c.brightYellow;
      color12 = c.brightBlue;
      color13 = c.brightMagenta;
      color14 = c.brightCyan;
      color15 = c.brightWhite;
    };
  };
}
