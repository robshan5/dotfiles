{ config, pkgs, lib, inputs, ... }:

{
    imports = [
        ./user/programs/zsh/default.nix
        ./user/programs/hyprland/default.nix
        ./user/programs/kitty/default.nix
        ./user/programs/nvim/default.nix
        ./user/programs/rofi/default.nix
        ./user/programs/yazi/default.nix
        ./user/programs/waybar/default.nix
        ./user/programs/firefox/default.nix
        ./user/programs/dunst/default.nix
        # inputs.textfox.homeManagerModules.default
    ];
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "robshan";
    home.homeDirectory = "/home/robshan";

    home.stateVersion = "25.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    nixpkgs.config.allowUnfreePredicate = _: true;
    home.packages = with pkgs; [
        #status bars
        waybar

        #programs
        kitty
        firefox
        zsh
        rofi
        vim
        vlc
        yazi
        transmission_4-gtk
        spotify
        libreoffice
        obsidian
        ffmpeg

        #lock screen
        hyprlock

        ##screenshot tools
        hyprshot

        ##notifications
        dunst
        libnotify

        #utilities
        wget
        git
        fzf
        unzip
        zip
        zoxide
        wayland-utils

        ##wallpapers
        hyprpaper

        # starship
        wl-clipboard
        xwayland
        gtk-layer-shell
        noto-fonts
        font-awesome
        jq

        ##networking
        networkmanagerapplet
        networkmanager
        gnome-keyring
        blueman
        kdePackages.kwallet-pam
        volumeicon
        flameshot

        brightnessctl
        playerctl
        gnuplot
        cargo
        wine
        glxinfo

        #keyboard keys
        wev

        nerd-fonts.jetbrains-mono
        nerd-fonts.recursive-mono
    ];

    home.file = {
    };

    home.keyboard.layout = "uk";

    home.sessionVariables = {
        # EDITOR = "emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
