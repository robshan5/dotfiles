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
                "localhost"
            ];
        };
    };

    services.nginx.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 442 ];
}
