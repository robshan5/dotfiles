{ ... }:

{
    environment.etc."nextcloud-admin-pass".text = "PWD";
    services.nextcloud = {
        enable = true;
        hostName = "nextcloud.local";       

        database.createLocally = true;

        config = {
            dbtype = "sqlite";
            adminuser = "admin";
            adminpassFile = "/var/lib/nextcloud/admin-pass";
        };
        settings = {
            trusted_domains = [
                "192.168.15.217"
                "100.106.29.22"
                "cloud.robshan.space"
                "localhost"
            ];
        };
    };

    services.nginx.enable = true;
    # services.nginx.virtualHosts."cloud.robshan.space" = {
    #     locations."/" = {
    #         proxyPass = "http://127.0.0.1:8080";
    #     #     proxyPreserveHost = true;
    #     };
    #     enableACME = true;
    # };

    # security.acme.certs."cloud.robshan.space".email = "robshanahan@duck.com";
    # security.acme.acceptTerms = true;

    networking.firewall.allowedTCPPorts = [ 80 442 ];
}
