{ pkgs, lib, vars, ... }:
let
  # Each theme lists the nixpkgs attribute paths of the fonts it needs
  # (see ../../themes/*.nix), so switching theme switches the installed fonts.
  resolve =
    path:
    lib.attrByPath (lib.splitString "." path)
      (throw "theme font package '${path}' does not exist in nixpkgs")
      pkgs;

  themeFonts = map resolve vars.theme.fonts.packages;
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
