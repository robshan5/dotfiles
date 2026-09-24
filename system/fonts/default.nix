{ pkgs, vars, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
      nerd-fonts.jetbrains-mono
      nerd-fonts.recursive-mono
    ];

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
