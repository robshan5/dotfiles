{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = builtins.toPath ./themes/nord.rasi;
  };
}
