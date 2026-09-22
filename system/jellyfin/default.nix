{ pkgs, vars, ... }:

{
    services.jellyfin = {
        enable = true;
        openFirewall = true;
    };

    # VAAPI hardware acceleration. services.jellyfin has no
    # `hardwareAcceleration` option; enable transcoding in the Jellyfin
    # dashboard (Playback) and provide the GPU driver stack here.
    users.users.jellyfin.extraGroups = [ "render" "video" ];
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            intel-media-driver # Intel iGPU (Broadwell+); change for your GPU
            vaapiVdpau
            libvdpau-va-gl
        ];
    };

    services.nginx.virtualHosts."jellyfin.${vars.domain}" = {
        # serverAliases = [ "www.jellyfin.robshan.space" ];

        locations."/" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true; # Jellyfin uses websockets
                # proxyPreserveHost = true;
        };

        # HTTPS
        enableACME = true;
    };

    security.acme.certs."jellyfin.${vars.domain}".email = vars.acmeEmail;
    security.acme.acceptTerms = true;
}
