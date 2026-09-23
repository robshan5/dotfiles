{ config, vars, ... }:
let
  c = vars.theme.colors;
  f = vars.theme.fonts;
  o = vars.theme.opacity;
in
{
  # Only the `drun` launcher is used - see the hyprland/sway keybinds.
  programs.rofi = {
    enable = true;
    font = "${f.mono} ${toString f.sizeMenu}";

    extraConfig = {
      modes = "drun";
      show-icons = true;
      drun-display-format = "{name}";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral c.foreground;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };

      "window" = {
        location = mkLiteral "center";
        width = mkLiteral "600px";
        border = mkLiteral "2px";
        border-color = mkLiteral c.brightWhite;
        border-radius = mkLiteral "16px";
        background-color = mkLiteral "${c.background}${o.panel}";
      };

      "mainbox" = {
        padding = mkLiteral "12px";
        children = map mkLiteral [ "inputbar" "listview" ];
      };

      "inputbar" = {
        background-color = mkLiteral "${c.surface}${o.input}";
        border = mkLiteral "2px";
        border-color = mkLiteral c.brightWhite;
        border-radius = mkLiteral "12px";
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "prompt".text-color = mkLiteral c.comment;

      "entry" = {
        placeholder = "Search";
        placeholder-color = mkLiteral c.overlay;
      };

      "listview" = {
        margin = mkLiteral "12px 0 0";
        lines = 10;
        columns = 1;
        fixed-height = false;
        scrollbar = false;
      };

      "element" = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "12px";
      };

      "element selected" = {
        background-color = mkLiteral c.highlight;
        text-color = mkLiteral c.onHighlight;
      };

      "element-icon" = {
        size = mkLiteral "1.2em";
        vertical-align = mkLiteral "0.5";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
