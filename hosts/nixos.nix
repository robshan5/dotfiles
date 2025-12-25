{ ... }:

{
    imports = [
        ../configuration.nix
        ../system/users/nix_server.nix
        ../system/jellyfin/default.nix
        ../system/transmission/default.nix
    ];
}
