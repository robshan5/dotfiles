{ pkgs, ... }:

{
    environment.etc."nextcloud-admin-pass".text = "PWD";
    services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;
        hostName = "localhost";
        config.adminpassFile = "/etc/nextcloud-admin-pass";
        config.dbtype = "sqlite";

        settings = {
            trusted_domains = [
                "192.168.15.217"
                "localhost"
            ];
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

<<<<<<< HEAD
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
=======
    environment.etc."nextcloud-admin-pass".text = "PWD";
    networking.firewall.allowedTCPPorts = [ 80 443 ];


    virtualisation.oci-containers = {
        backend = "docker"; # or "podman"

            containers.collabora = {
                image = "collabora/code";
                ports = [ "9980:9980" ];
                environment = {
                    domain = "192\\.168\\.15\\.217"; # IMPORTANT: escaped dots
                };
            };
    };
>>>>>>> 2dee3162b60d1df27e8984644b6734f25ed72797
}
