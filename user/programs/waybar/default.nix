{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
  };

  # Use relative paths for Waybar configuration files
  home.file.".config/waybar/" = {
    source = ./waybar; # Relative path to the Waybar config file
  };
}

