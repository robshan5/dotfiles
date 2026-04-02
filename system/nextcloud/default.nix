{ pkgs, ... }:

{
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
    };

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
}
