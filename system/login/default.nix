{ pkgs, vars, ... }:
let
    # The package installs to themes/catppuccin-<flavor>-<accent>, so the name
    # handed to sddm has to be built the same way or the greeter falls back.
    themeName = "catppuccin-${vars.login.flavor}-${vars.login.accent}";

    # Themed SDDM greeter instead of the stock Breeze/KDE one.
    # An empty background falls back to the theme's own artwork.
    sddmTheme = pkgs.catppuccin-sddm.override ({
        inherit (vars.login) flavor accent font fontSize;
    } // (if vars.login.background == null then { } else {
        background = "${vars.login.background}";
        loginBackground = true;
    }));
in
{
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = themeName;
        extraPackages = [ sddmTheme ];

        settings = {
            Theme.CursorTheme = vars.login.cursorTheme;
            General.InputMethod = "";   # no on-screen virtual keyboard
        };
    };

    # The theme has to exist system-wide for sddm (running as its own user) to find it.
    environment.systemPackages = [ sddmTheme ];
}
