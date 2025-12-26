{ ... }:

{
    networking.hostName = "laptop"; # Define your hostname.

    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
        ../../system/users/robshan.nix
        ../../system/wm/default.nix
        ../../system/audio/default.nix
    ];
}
