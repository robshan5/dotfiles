{config, pkgs, ...}:

{
  programs.starship = {
    enable = true;
    settings = {
      username = { style_user = "bold #cf6a4c"; };
      directory = { style = "bold #8f9d6a"; };
      git_branch = { style = "bold #f9ee98"; };
      git_status = { style = "#cf6a4c"; };
      status = {
        style = "bold #c3bf9f";
      };
      character = {
        success_symbol = "[➜](#e9c062)";
        error_symbol = "[➜](#cf6a4c)";
      };
      time = {
        style = "bold #8f9d6a";
        format = "[$time]($style)";
      };
    };
  };
}
