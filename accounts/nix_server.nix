{ pkgs, ... }:

{
    imports = [
        ../home.nix
    ];

    home.packages = with pkgs; [
        openssh
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
        tmux
    ];
}
