{ pkgs, inputs, ... }:

{
    imports = [
        ../home.nix
        ../user/programs/hyprland/default.nix
        ../user/programs/rofi/default.nix
        ../user/programs/yazi/default.nix
        ../user/programs/waybar/default.nix
        ../user/programs/firefox/default.nix
        ../user/programs/dunst/default.nix
        ../user/programs/ssh/default.nix
        inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser.enable = true;

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

        wl-clipboard
        xwayland
        gtk-layer-shell
        noto-fonts
        font-awesome
        nerd-fonts.recursive-mono
        nerd-fonts.jetbrains-mono
        jq
        poppler-utils

        ##networking
        networkmanagerapplet
        networkmanager
        blueman
        volumeicon

        brightnessctl
        playerctl
        gnuplot
        cargo
        wine
        parted
        mesa-demos
        file
        hdparm
        gptfdisk
    ];
}
