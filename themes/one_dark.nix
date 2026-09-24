# One Dark.
#
# A theme module: colours, fonts and opacity consumed by kitty, waybar, dunst
# and rofi. Swap the whole look by pointing `theme` in ../vars.nix at a
# different file in this directory.
{
  fonts = {
    mono = "Recursive Mono";              # terminal / UI
    nerd = "JetBrainsMono Nerd Font";     # glyph fallback for bar + notifications
    sizeTerminal     = 11;
    sizeBar          = 13;
    sizeNotification = 10;
    sizeMenu         = 12;
  };

  # `rec` so the semantic names below can reuse the palette.
  colors = rec {
    background = "#141619";  # darker than stock One Dark (#282c34)
    surface    = "#282c34";  # inputs, secondary panels
    overlay    = "#3d4350";  # borders, separators
    selection  = "#3e4451";
    foreground = "#abb2bf";
    comment    = "#5c6370";  # dimmed text / placeholders
    cursor     = "#abb2bf";

    black   = "#282c34";
    red     = "#e06c75";
    green   = "#98c379";
    yellow  = "#e5c07b";
    blue    = "#61afef";
    magenta = "#c678dd";
    cyan    = "#56b6c2";
    white   = "#abb2bf";

    brightBlack   = "#5c6370";
    brightRed     = "#e06c75";
    brightGreen   = "#98c379";
    brightYellow  = "#e5c07b";
    brightBlue    = "#61afef";
    brightMagenta = "#c678dd";
    brightCyan    = "#56b6c2";
    brightWhite   = "#ffffff";

    # Semantic aliases - point these at any palette entry above.
    accent       = yellow;      # active workspace, kitty tab bar
    highlight    = blue;        # rofi selected entry
    onHighlight  = "#000000";   # text drawn on top of `highlight`
    alert        = red;         # critical notifications, muted audio
    border       = brightWhite; # matches hyprland's active window border
  };

  # Two hex digits appended to a colour, e.g. rofi panel translucency.
  opacity = {
    panel = "F2";  # ~95%
    input = "FF";
    row   = "80";  # ~50%
  };
}
