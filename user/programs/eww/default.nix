{config, pkgs, ...}:
let
  # ewwbar = pkgs.fetchFromGitHub {
  #   owner = "alsocube";
  #   repo = "my-eww-bar";
  #   rev = "master";
  #   sha256 = "0bgmd9fyd19ib2zg8lxpbw0vk7pyvrk17abpll6jwzf0xpkk6y4b";
  # };
  ewwbar = builtins.path ./my-eww-bar;
in {
  home.packages = with pkgs; [
    eww
    nodejs
    git
  ];
  home.file."~/.config/eww" = {
    source = ewwbar;
  };
}
