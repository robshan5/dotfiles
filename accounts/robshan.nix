{ pkgs, ... }:

{
    imports = [
        ../home.nix
        ../user/programs/hyprland/default.nix
        ../user/programs/kitty/default.nix
        ../user/programs/rofi/default.nix
        ../user/programs/yazi/default.nix
        ../user/programs/waybar/default.nix
        ../user/programs/firefox/default.nix
        ../user/programs/dunst/default.nix
    ];


    nixpkgs.config.allowUnfreePredicate = _: true;
    home.packages = with pkgs; [
        #status bars
        waybar

        #programs
        rofi
        vlc
        yazi
        transmission_4-gtk
        spotify
        libreoffice
        obsidian
        typst
        ffmpeg

        #image viewer
        nomacs
        mpv

        #lock screen
        hyprlock

        ##screenshot tools
        hyprshot

        ##notifications
        dunst
        libnotify

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

        brightnessctl
        playerctl
        gnuplot
        cargo
        wine
        glxinfo


        nerd-fonts.jetbrains-mono
        nerd-fonts.recursive-mono
        roboto
        source-sans-pro
    ];
}
