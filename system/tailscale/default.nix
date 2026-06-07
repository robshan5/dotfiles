{ config, pkgs, ... }:

{
    services.headscale = {
        enable  = true;
        address = "127.0.0.1";
        port    = 8080;

        settings = {
            server_url  = "https://headscale.robshan.space";
            ip_prefixes = [ "100.64.0.0/10" "fd7a:115c:a1e0::/48" ];

            dns = {
                override_local_dns = true;
                nameservers.global = [ "1.1.1.1" "8.8.8.8" ];
                magic_dns          = true;
                base_domain        = "robshan.space";
            };

            # Uses Tailscale's public DERP relays — works out of the box.
            # Host your own DERP later if you want fully self-contained operation.
            derp.urls = [
                "https://controlplane.tailscale.com/derpmap/default"
            ];

            grpc_listen_addr    = "127.0.0.1:50443";
            grpc_allow_insecure = false;
        };
    };

}
