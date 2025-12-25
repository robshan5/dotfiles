{ ... }:

{
    imports = [
        ./home.nix
        ./accounts/nix_server.nix
        ./user/programs/zsh/default.nix
        ./user/programs/hyprland/default.nix
        ./user/programs/kitty/default.nix
        ./user/programs/rofi/default.nix
        ./user/programs/yazi/default.nix
        ./user/programs/waybar/default.nix
        ./user/programs/firefox/default.nix
        ./user/programs/dunst/default.nix
    ];
}
