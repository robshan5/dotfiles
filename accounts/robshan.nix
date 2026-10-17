{ pkgs, lib, inputs, vars, ... }:
let
  # Installed here as well as system-wide so that switching theme and running
  # `home-manager switch` alone still gets the fonts the new theme asks for.
  themeFonts = import ../themes/font-packages.nix {
    inherit lib pkgs;
    theme = vars.theme;
  };
in
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
        # Generic families; the active theme's own fonts are appended below.
        noto-fonts
        font-awesome
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
        proton-vpn
    ] ++ themeFonts;
}
