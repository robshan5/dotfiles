# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, vars, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./system/keyboard/default.nix
            ./system/bootloader/default.nix
            ./system/networking/default.nix
            ./system/time/default.nix
        ];

    programs.zsh.enable = true;

    #Stylix Customisation
    # stylix.enable = true;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc.lib
        gcc
        zlib
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = vars.stateVersion; # Did you read the comment?

    nix.settings.experimental-features = ["nix-command" "flakes"];
}
