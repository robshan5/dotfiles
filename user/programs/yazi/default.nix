{pkgs, lib, ...}:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    package = pkgs.yazi;
    plugins = {
    };
  };
}
