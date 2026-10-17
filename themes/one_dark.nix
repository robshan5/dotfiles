# One Dark.
#
# A theme module: colours, fonts and opacity consumed by kitty, waybar, dunst,
# rofi and neovim. Swap the whole look by pointing `theme` in ../vars.nix at a
# different file in this directory.
{
    name = "One Dark";

    # Let the terminal / compositor show through instead of painting a
    # background. Honoured by the generated neovim colourscheme.
    transparent = true;

    fonts = {
        # Family names as fontconfig reports them (`fc-list : family`).
        mono = "JetBrainsMono Nerd Font";     # terminal / UI
        nerd = "JetBrainsMono Nerd Font";     # glyph fallback for bar + notifications
        # nixpkgs attribute paths providing the families above. Installed by
        # ../system/fonts/default.nix and the Home Manager profile, so a theme
        # brings its own fonts - see ./font-packages.nix.
        packages = [
            "nerd-fonts.jetbrains-mono"
        ];
        sizeTerminal     = 11;
        sizeBar          = 13;
        sizeNotification = 10;
        sizeMenu         = 12;
    };

    # `rec` so the semantic names below can reuse the palette.
    colors = rec {
        # --- Surfaces and text --------------------------------------------
        background = "#141619";  # darker than stock One Dark (#282c34)
        surface    = "#282c34";  # inputs, secondary panels, completion menus
        overlay    = "#3d4350";  # borders, separators, indent guides
        selection  = "#3e4451";
        foreground = "#abb2bf";
        comment    = "#5c6370";  # dimmed text / placeholders
        cursor     = "#abb2bf";
        cursorLine = "#1d2026";  # stripe under the editor's current line
        lineNumber = "#4b515c";  # inactive gutter numbers

        # --- 16 colour terminal palette -----------------------------------
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

        # --- Extra hues the 16 colour palette has no slot for --------------
        orange    = "#d19a66";  # numbers, constants, booleans
        darkRed   = "#be5046";  # deprecated code, deleted hunks
        lightGrey = "#848b98";  # punctuation, inactive statusline text

        # Semantic aliases - point these at any palette entry above.
        accent       = yellow;      # active workspace, kitty tab bar
        highlight    = blue;        # rofi selected entry
        onHighlight  = "#000000";   # text drawn on top of `highlight`
        alert        = red;         # critical notifications, muted audio
        border       = brightWhite; # matches hyprland's active window border
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
        diffAdd    = "#1e2b22";
        diffChange = "#1c2430";
        diffDelete = "#2b1f22";
        diffText   = "#2d4154";  # the changed span inside a changed line

        # --- Syntax roles ---------------------------------------------------
        # What an editor paints code with; `comment` above is reused as-is.
        syntax = {
            keyword     = magenta;
            func        = blue;
            string      = green;
            character   = green;
            number      = orange;
            boolean     = orange;
            constant    = orange;
            type        = yellow;
            variable    = foreground;
            property    = red;        # struct fields, object members
            parameter   = red;
            operator    = cyan;
            punctuation = lightGrey;
            preproc     = magenta;    # macros, imports, pragmas
            tag         = red;        # html/jsx element names
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
