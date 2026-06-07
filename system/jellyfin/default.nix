{ pkgs, ... }:

{
    services.jellyfin = {
        enable = true;
        openFirewall = true;
    };

    services.nginx.virtualHosts."jellyfin.robshan.space" = {
        # serverAliases = [ "www.jellyfin.robshan.space" ];

        locations."/" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true; # Jellyfin uses websockets
                # proxyPreserveHost = true;
        };

        # HTTPS
        enableACME = true;
    };

    security.acme.certs."jellyfin.robshan.space".email = "robshanahan@duck.com";
    security.acme.acceptTerms = true;
}
