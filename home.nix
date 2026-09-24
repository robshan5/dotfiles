{ vars, ... }:

{
    imports = [
        ./user/programs/nvim/default.nix
        ./user/programs/zsh/default.nix
        ./user/programs/packages.nix
        ./user/programs/kitty/default.nix
    ];

    home.stateVersion = vars.stateVersion; # Please read the comment before changing.

    # Required for fonts installed via home.packages to be visible to fontconfig.
    fonts.fontconfig.enable = true;

    home.file = {
    };

    home.keyboard.layout = vars.homeKeyboardLayout;

    home.sessionVariables = {
        # EDITOR = "emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
