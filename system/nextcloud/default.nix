{ ... }:

{
    services.nextcloud = {
        enable = true;
        hostName = "nextcloud.local";       

        database.createLocally = true;

        config = {
            dbtype = "sqlite";
            adminuser = "admin";
            adminpassFile = "/var/lib/nextcloud/admin-pass";
        };
    };

    services.nginx.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 442 ];
}
