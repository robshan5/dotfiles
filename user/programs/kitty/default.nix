{ inputs, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Nord";

    extraConfig = ''
      background_opacity 0.82
    '';
  };
}
