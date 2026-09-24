{ vars, ... }:
let
  c = vars.theme.colors;
  f = vars.theme.fonts;
in
{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar/config.jsonc".source = ./waybar/config.jsonc;

  # style.css is a template - placeholders are filled from vars.theme.
  home.file.".config/waybar/style.css".text = builtins.replaceStrings
    [ "@background@" "@foreground@" "@surface@" "@accent@" "@alert@" "@border@" "@font@" "@nerdfont@" "@fontsize@" ]
    [ c.background c.foreground c.surface c.accent c.alert c.border f.mono f.nerd (toString f.sizeBar) ]
    (builtins.readFile ./waybar/style.css);
}

