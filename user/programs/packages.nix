{ pkgs, ... }:

{
    home.packages = with pkgs; [
        #utilities
        wget
        git
        fzf
        unzip
        zip
        zoxide
        wayland-utils
        btop
        openssh
        sshfs
        tree
    ];
}
