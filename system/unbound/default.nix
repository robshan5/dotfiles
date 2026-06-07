{...}:

{
    services.unbound = {
        enable = true;

        settings = {
            server = {
                # Listen on all interfaces so LAN devices can reach it
                interface = [ "0.0.0.0" "::0" ];
                port      = 53;

                # Allow queries from your LAN (adjust subnet if yours differs)
                access-control = [
                    "127.0.0.0/8 allow"
                    "192.168.0.0/16 allow"
                    "10.0.0.0/8 allow"
                    "::1/128 allow"
                ];

                # Hardening
                hide-identity = true;
                hide-version  = true;
                harden-glue   = true;
                harden-dnssec-stripped = true;
                use-caps-for-id = true;

                # Cache
                cache-min-ttl = 300;
                cache-max-ttl = 86400;

                # Performance
                num-threads        = 2;
                so-rcvbuf          = "1m";
                prefetch           = true;
                prefetch-key       = true;

                # ── Local zone for robshan.space ──────────
                # Replace 192.168.1.x with your server's actual LAN IP!
                local-zone = [ ''"robshan.space." static'' ];
                local-data = [
                    ''"robshan.space.            A 192.168.1.x"''   # <── change IP
                    ''"nextcloud.robshan.space.  A 192.168.1.x"''   # <── change IP
                    ''"jellyfin.robshan.space.   A 192.168.1.x"''   # <── change IP
                    ''"headscale.robshan.space.  A 192.168.1.x"''   # <── change IP
                ];
            };

            # Forward all other queries upstream via DNS-over-TLS
            forward-zone = [
                {
                    name              = ".";
                    forward-tls-upstream = true;
                    forward-addr = [
                        "1.1.1.1@853#cloudflare-dns.com"
                        "1.0.0.1@853#cloudflare-dns.com"
                        "8.8.8.8@853#dns.google"
                        "8.8.4.4@853#dns.google"
                    ];
                }
            ];
        };
    };

    # Make the server use its own DNS (so it can resolve robshan.space too)
    networking.nameservers = [ "127.0.0.1" "::1" ];
}
