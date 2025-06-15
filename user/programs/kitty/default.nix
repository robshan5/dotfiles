{ inputs, pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];
  programs.kitty = {
    enable = true;
    themeFile = "OneDark";
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "Recursive Mono";
      size = 11;
    };

    extraConfig = ''
      background #141619
    '';
  };
}
