# Catppuccin Mocha.
#
# A theme module: colours, fonts and opacity consumed by kitty, waybar, dunst,
# rofi and neovim. Swap the whole look by pointing `theme` in ../vars.nix at a
# different file in this directory.
#
# Softer counterpart to one_dark.nix: pastel Catppuccin hues paired with
# Maple Mono NF, a rounded typeface that carries its own Nerd Font glyphs
# (installed by ../system/fonts/default.nix).
{
    name = "Catppuccin Mocha";

    # Let the terminal / compositor show through instead of painting a
    # background. Honoured by the generated neovim colourscheme.
    transparent = true;

    fonts = {
        mono = "Maple Mono NF";               # terminal / UI
        nerd = "Maple Mono NF";               # glyph fallback for bar + notifications
        # nixpkgs attribute paths providing the families above. Installed by
        # ../system/fonts/default.nix, so a theme brings its own fonts.
        # The NF build is already Nerd Font patched, so one package covers both.
        packages = [
            "maple-mono.NF"
        ];
        sizeTerminal     = 11;
        sizeBar          = 13;
        sizeNotification = 10;
        sizeMenu         = 12;
    };

    # `rec` so the semantic names below can reuse the palette.
    colors = rec {
        # --- Surfaces and text --------------------------------------------
        background = "#1e1e2e";  # base
        surface    = "#313244";  # surface0 - inputs, secondary panels, menus
        overlay    = "#585b70";  # surface2 - borders, separators, indent guides
        selection  = "#45475a";  # surface1
        foreground = "#cdd6f4";  # text
        comment    = "#7f849c";  # overlay1 - dimmed text / placeholders
        cursor     = "#f5e0dc";  # rosewater
        cursorLine = "#181825";  # mantle - stripe under the current line
        lineNumber = "#6c7086";  # overlay0 - inactive gutter numbers

        # --- 16 colour terminal palette -----------------------------------
        black   = "#45475a";
        red     = "#f38ba8";
        green   = "#a6e3a1";
        yellow  = "#f9e2af";
        blue    = "#89b4fa";
        magenta = "#f5c2e7";  # pink
        cyan    = "#94e2d5";  # teal
        white   = "#bac2de";  # subtext1

        brightBlack   = "#585b70";
        brightRed     = "#f38ba8";
        brightGreen   = "#a6e3a1";
        brightYellow  = "#f9e2af";
        brightBlue    = "#89b4fa";
        brightMagenta = "#f5c2e7";
        brightCyan    = "#94e2d5";
        brightWhite   = "#a6adc8";  # subtext0

        # --- Extra hues the 16 colour palette has no slot for --------------
        orange    = "#fab387";  # peach - numbers, constants, booleans
        darkRed   = "#eba0ac";  # maroon - deprecated code, deleted hunks
        lightGrey = "#a6adc8";  # subtext0 - punctuation, inactive statusline

        # Semantic aliases - point these at any palette entry above.
        mauve        = "#cba6f7";
        lavender     = "#b4befe";
        accent       = mauve;       # active workspace, kitty tab bar
        highlight    = blue;        # rofi selected entry
        onHighlight  = "#11111b";   # crust - text drawn on top of `highlight`
        alert        = red;         # critical notifications, muted audio
        border       = lavender;    # matches hyprland's active window border
        float        = background;  # floating windows / popups - match the editor bg
        floatBorder  = overlay;

        # --- Diagnostics (LSP severities) ----------------------------------
        error   = red;
        warning = yellow;
        info    = blue;
        hint    = cyan;
        ok      = green;

        # --- Version control -----------------------------------------------
        gitAdd    = green;
        gitChange = yellow;
        gitDelete = red;

        # Diff row backgrounds - tinted versions of `background`.
        diffAdd    = "#28352f";
        diffChange = "#262b40";
        diffDelete = "#3a2432";
        diffText   = "#394460";  # the changed span inside a changed line

        # --- Syntax roles ---------------------------------------------------
        # What an editor paints code with; `comment` above is reused as-is.
        syntax = {
            keyword     = mauve;
            func        = blue;
            string      = green;
            character   = green;
            number      = orange;
            boolean     = orange;
            constant    = orange;
            type        = yellow;
            variable    = foreground;
            property    = lavender;   # struct fields, object members
            parameter   = darkRed;    # maroon, as upstream Catppuccin does
            operator    = cyan;
            punctuation = lightGrey;
            preproc     = magenta;    # macros, imports, pragmas
            tag         = mauve;      # html/jsx element names
            attribute   = yellow;     # html/jsx attributes, decorators
            special     = cyan;       # escape sequences, format specifiers
            deprecated  = darkRed;
        };
    };

    # Two hex digits appended to a colour, e.g. rofi panel translucency.
    opacity = {
        panel = "F2";  # ~95%
        input = "FF";
        row   = "80";  # ~50%
    };
}
