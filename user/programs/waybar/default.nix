{ vars, ... }:
let
  c = vars.theme.colors;
  f = vars.theme.fonts;

  # Both waybar files are templates - placeholders are filled from vars.theme.
  substitute =
    names: values: file:
    builtins.replaceStrings names values (builtins.readFile file);
in
{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar/config.jsonc".text = substitute
    [ "@foreground@" "@accent@" "@red@" "@blue@" ]
    [ c.foreground c.accent c.red c.blue ]
    ./waybar/config.jsonc;

  home.file.".config/waybar/style.css".text = substitute
    [ "@background@" "@foreground@" "@surface@" "@accent@" "@alert@" "@border@" "@font@" "@nerdfont@" "@fontsize@" ]
    [ c.background c.foreground c.surface c.accent c.alert c.border f.mono f.nerd (toString f.sizeBar) ]
    ./waybar/style.css;
}

