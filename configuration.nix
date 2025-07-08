# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            ./system/keyboard/default.nix
            ./system/audio/default.nix
            ./system/bootloader/default.nix
            ./system/networking/default.nix
            ./system/time/default.nix
            ./system/users/default.nix
            ./system/wm/default.nix
        ];

    programs.zsh.enable = true;

    #Stylix Customisation
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.05"; # Did you read the comment?

    nix.settings.experimental-features = ["nix-command" "flakes"];
}
