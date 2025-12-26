{ ... }:

{
    networking.hostName = "nix_laptop"; # Define your hostname.

    imports = [
        ../configuration.nix
        ../system/users/robshan.nix
        ../system/wm/default.nix
        ../system/audio/default.nix
    ];
}
