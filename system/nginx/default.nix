{ pkgs, vars, ... }:

{
    services.nginx = {
        enable = true;
        recommendedGzipSettings  = true;
        recommendedOptimisation   = true;
        recommendedProxySettings  = true;
        recommendedTlsSettings    = true;
        package = pkgs.nginxMainline;

        virtualHosts = {

            # ── Nextcloud ──────────────────────────────
            # The nextcloud module hooks into this vhost automatically
            "nextcloud.${vars.domain}" = {
                forceSSL = true;
                sslCertificate    = "/etc/ssl/${vars.domain}.crt";
                sslCertificateKey = "/etc/ssl/${vars.domain}.key";
            };

            # ── Jellyfin ───────────────────────────────
            "jellyfin.${vars.domain}" = {
                forceSSL = true;
                sslCertificate    = "/etc/ssl/${vars.domain}.crt";
                sslCertificateKey = "/etc/ssl/${vars.domain}.key";
                locations."/" = {
                    proxyPass       = "http://127.0.0.1:8096";
                    proxyWebsockets = true;
                    extraConfig = ''
            proxy_buffering off;
                    '';
                };
            };

            # ── Headscale ──────────────────────────────
            "headscale.${vars.domain}" = {
                forceSSL = true;
                sslCertificate    = "/etc/ssl/${vars.domain}.crt";
                sslCertificateKey = "/etc/ssl/${vars.domain}.key";
                locations."/" = {
                    proxyPass       = "http://127.0.0.1:8080";
                    proxyWebsockets = true;
                };
                # gRPC endpoint used by headscale CLI / Tailscale clients
                # locations."/headscale.v1.HeadscaleService" = {
                    # proxyPass  = "grpc://127.0.0.1:50443";
                    # extraConfig = ''
            # grpc_set_header Host $host;
                    # '';
                # };
            };

        };
    };
}
