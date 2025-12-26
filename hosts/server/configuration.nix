{ ... }:

{
    networking.hostName = "server"; # Define your hostname.

    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
        ../../system/users/nix_server.nix
        ../../system/jellyfin/default.nix
        ../../system/transmission/default.nix
        ../../system/ssh/default.nix
    ];
}
