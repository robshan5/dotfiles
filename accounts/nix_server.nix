{ pkgs, ... }:

{
    imports = [
        ../home.nix
    ];

    home.packages = with pkgs; [
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
        tmux
        kitty
        starship
    ];
}
