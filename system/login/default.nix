{ pkgs, vars, ... }:
let
    # Themed SDDM greeter instead of the stock Breeze/KDE one.
    # An empty background falls back to the theme's own artwork.
    sddmTheme = pkgs.catppuccin-sddm.override ({
        inherit (vars.login) flavor font fontSize;
    } // (if vars.login.background == null then { } else {
        background = "${vars.login.background}";
        loginBackground = true;
    }));
in
{
    services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;   # Qt6 build, matches the theme
        wayland.enable = true;
        theme = "catppuccin-${vars.login.flavor}";
        extraPackages = [ sddmTheme ];

        settings = {
            Theme.CursorTheme = vars.login.cursorTheme;
            General.InputMethod = "";   # no on-screen virtual keyboard
        };
    };

    # The theme has to exist system-wide for sddm (running as its own user) to find it.
    environment.systemPackages = [ sddmTheme ];
}
