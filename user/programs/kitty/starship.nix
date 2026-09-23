{ vars, ... }:
let
  c = vars.theme.colors;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Finished prompts collapse to a bare chevron, so scrollback is mostly output.
    enableTransience = true;

    settings = {
      add_newline = true;
      command_timeout = 1000;

      # Info on the first line, the prompt itself on the second. Past prompts
      # collapse to the single-line transient prompt above.
      format = "$directory$git_branch$git_status$nix_shell$line_break$character";
      right_format = "$cmd_duration";

      character = {
        success_symbol = "[❯](bold ${c.green})";
        error_symbol = "[❯](bold ${c.red})";
        vimcmd_symbol = "[❮](bold ${c.yellow})";
      };

      directory = {
        style = "bold ${c.blue}";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        read_only = " ";
        read_only_style = c.red;
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = " ";
        style = c.magenta;
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = c.yellow;
        format = "[$all_status$ahead_behind]($style)";
      };

      nix_shell = {
        symbol = " ";
        style = c.cyan;
        format = "[$symbol$name]($style) ";
      };

      cmd_duration = {
        min_time = 2000;
        style = c.comment;
        format = "[$duration]($style)";
      };
    };
  };
}
