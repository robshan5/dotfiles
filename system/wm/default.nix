{input, pkgs, config, ...}:
{
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;
    hardware.graphics.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    #Enable sway
    programs.sway.enable = true;
    #Enable hyprland
    programs.hyprland.enable = true;
}
