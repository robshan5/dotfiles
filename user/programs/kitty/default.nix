{ inputs, pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];
  programs.kitty = {
    enable = true;
    themeFile = "Twilight";
    font = {
      name = "JetBrains Mono";
      size = 12;
    };

    extraConfig = ''
      background_opacity 0.82
      background #1a1a1a
    '';
  };
}
