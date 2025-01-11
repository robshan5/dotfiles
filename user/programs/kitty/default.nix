{ inputs, pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];
  programs.kitty = {
    enable = true;
    themeFile = "Twilight";

    extraConfig = ''
      background_opacity 0.82
    '';
  };
}
