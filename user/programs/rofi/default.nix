{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = builtins.toPath ./themes/rounded-red-dark.rasi;
  };
}
