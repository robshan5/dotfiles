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
        # WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
        };
        nvidia.modesetting.enable = true;
        nvidia.open = false;
    };

    programs.hyprland = {
        # nvidiaPatches = true;
        xwayland.enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];
}
