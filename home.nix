{ config, pkgs, lib, inputs, ... }:

{
    imports = [
        ./user/programs/nvim/default.nix
        ./user/programs/zsh/default.nix
        ./user/programs/packages.nix
        ./user/programs/kitty/default.nix
    ];

    home.stateVersion = "25.05"; # Please read the comment before changing.

    home.file = {
    };

    home.keyboard.layout = "uk";

    home.sessionVariables = {
        # EDITOR = "emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
