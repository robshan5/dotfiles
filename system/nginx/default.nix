{pkgs, ...}:

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
            "nextcloud.robshan.space" = {
                forceSSL = true;
                sslCertificate    = "/etc/ssl/robshan.space.crt";
                sslCertificateKey = "/etc/ssl/robshan.space.key";
            };

            # ── Jellyfin ───────────────────────────────
            "jellyfin.robshan.space" = {
                forceSSL = true;
                sslCertificate    = "/etc/ssl/robshan.space.crt";
                sslCertificateKey = "/etc/ssl/robshan.space.key";
                locations."/" = {
                    proxyPass       = "http://127.0.0.1:8096";
                    proxyWebsockets = true;
                    extraConfig = ''
            proxy_buffering off;
                    '';
                };
            };

            # ── Headscale ──────────────────────────────
            "headscale.robshan.space" = {
                forceSSL = true;
                sslCertificate    = "/etc/ssl/robshan.space.crt";
                sslCertificateKey = "/etc/ssl/robshan.space.key";
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
