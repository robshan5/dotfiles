{ lib, ... }:
{
    # ---------------------------------------------------------------------
    # Boot speed
    # Check the damage afterwards with:
    #   systemd-analyze          / systemd-analyze blame
    #   systemd-analyze critical-chain
    # ---------------------------------------------------------------------

    # Don't sit in the boot menu waiting for a keypress.
    boot.loader.timeout = lib.mkDefault 1;

    # systemd in the initrd: units start in parallel instead of the old
    # sequential bash stage-1 script.
    boot.initrd.systemd.enable = lib.mkDefault true;

    # Silent boot - console logging is synchronous and genuinely costs time.
    boot.initrd.verbose = false;
    boot.consoleLogLevel = 0;
    boot.kernelParams = [
        "quiet"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "systemd.show_status=auto"
    ];

    # The usual worst offender: these block network-online.target (and so
    # everything ordered after it) until a routable address appears.
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;

    # Deprecated serialisation point - nothing here needs it.
    systemd.services.systemd-udev-settle.enable = false;

    # A hung unit should not cost 90s of boot or shutdown.
    # systemd.extraConfig = ''
    #     DefaultTimeoutStartSec=15s
    #     DefaultTimeoutStopSec=10s
    #     DefaultDeviceTimeoutSec=15s
    # '';
    systemd.user.extraConfig = ''
        DefaultTimeoutStopSec=10s
    '';

    # Keep the journal from growing until every boot pays to index it.
    services.journald.extraConfig = ''
        SystemMaxUse=250M
        SystemMaxFileSize=50M
    '';

    # Services that are on by default and that this setup never uses.
    services.speechd.enable = lib.mkDefault false;          # orca TTS daemon
    documentation.nixos.enable = lib.mkDefault false;       # nixos-help HTML manual
    documentation.info.enable = lib.mkDefault false;
}
