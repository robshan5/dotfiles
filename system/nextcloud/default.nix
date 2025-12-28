{ ... }:

{
    services.nextcloud = {
        enable = true;
        
        database.createLocally = true;

        config = {
            adminuser = "admin";
            adminpassFile = "/var/lib/nextcloud/admin-pass";
        };
    };

    services.nginx.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 442 ];
}
