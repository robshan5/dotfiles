{ pkgs, lib, vars, ... }:
let
  # Fonts named by the active theme - see ../../themes/font-packages.nix.
  themeFonts = import ../../themes/font-packages.nix {
    inherit lib pkgs;
    theme = vars.theme;
  };
in
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    # Generic families every theme relies on, plus the active theme's own.
    # nerd-fonts.jetbrains-mono is here rather than in a theme because the sddm
    # greeter is themed separately, from vars.login.font.
    packages = lib.unique (
      (with pkgs; [
        noto-fonts
        noto-fonts-color-emoji
        font-awesome
        nerd-fonts.jetbrains-mono
      ])
      ++ themeFonts
    );

    # Without these, anything requesting a generic family (Hyprland's own error
    # bar and notifications ask for "Sans") renders as empty boxes.
    fontconfig.defaultFonts = {
      monospace = [ vars.theme.fonts.nerd ];
      sansSerif = [ "Noto Sans" vars.theme.fonts.nerd ];
      serif = [ "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
