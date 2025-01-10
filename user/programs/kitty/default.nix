{ inputs, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "OneDark-Pro";

    extraConfig = ''
      background_opacity 0.82
    '';
  };
}
