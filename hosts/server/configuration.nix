{ ... }:

{
    networking.hostName = "server"; # Define your hostname.

    services.logind = {
        lidSwitchExternalPower = "ignore";
        lidSwitch = "ignore";
    };

    system.autoUpgrade = {
        enable      = true;
        allowReboot = false;
    };

    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
        ../../system/users/nix_server.nix
        ../../system/jellyfin/default.nix
        ../../system/transmission/default.nix
        ../../system/ssh/default.nix
        ../../system/nextcloud/default.nix
        ../../system/tailscale/default.nix
    ];

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [
            22    # SSH
            53    # DNS (Unbound)
            80    # HTTP  → nginx (redirects to HTTPS)
            443   # HTTPS → nginx
            41641 # Headscale/Tailscale DERP (TCP)
        ];
        allowedUDPPorts = [
            53    # DNS (Unbound)
            41641 # Headscale/Tailscale DERP (UDP)
        ];
    };
}
