{ ... }:

{
    services.transmission = {
        enable = true;
        openFirewall = true;
        settings = {
            download-dir = "/data/torrents";
            incomplete-dir = "/data/torrents/.incomplete";
            incomplete-dir-enabled = true;
            rpc-enabled = true;
            rpc-bind-address = "127.0.0.1";
            rpc-whitelist = "127.0.0.1,192.168.15.255";
            rpc-authentication-required = false;
        };
    };
}
