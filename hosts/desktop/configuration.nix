{ ... }:

{
    networking.hostName = "laptop"; # Define your hostname.

    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
        ../../system/users/robshan.nix
        ../../system/wm/default.nix
        ../../system/audio/default.nix
        ../../system/tailscale/client.nix
    ];

    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };

    hardware = {
        graphics.enable = true;
        nvidia.modesetting.enable = true;
    };
}
