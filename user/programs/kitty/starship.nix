{ lib, vars, ... }:
let
  c = vars.theme.colors;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      command_timeout = 1000;

      # Info on the first line, the prompt itself on the second. Once a command
      # runs the whole thing is redrawn as the `transient` profile below.
      format = "$directory$git_branch$git_status$nix_shell$line_break$character";
      right_format = "$cmd_duration";

      profiles.transient = "$character";

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

  # Starship only ships a transient prompt for fish/cmd, so zsh gets it here.
  # mkAfter keeps this below the `starship init zsh` that home-manager emits.
  programs.zsh.initContent = lib.mkAfter ''
    if [[ $TERM != "dumb" ]]; then
      # starship sets PROMPT once and relies on promptsubst, so stash the real
      # one and put it back before every new prompt is drawn.
      _starship_prompt_full=$PROMPT
      _starship_rprompt_full=$RPROMPT

      _starship_transient_prompt() {
        PROMPT="$(starship prompt --profile transient --terminal-width="$COLUMNS")"
        RPROMPT=""
        zle .reset-prompt
      }

      _starship_restore_prompt() {
        PROMPT=$_starship_prompt_full
        RPROMPT=$_starship_rprompt_full
      }
      precmd_functions=(_starship_restore_prompt $precmd_functions)

      zle-line-finish() { _starship_transient_prompt }
      zle -N zle-line-finish

      # Ctrl-C should collapse the prompt too.
      TRAPINT() {
        [[ -o zle ]] && _starship_transient_prompt
        return $(( 128 + $1 ))
      }
    fi
  '';
}
