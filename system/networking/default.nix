{ vars, ... }:
{

    # Enable networking
    networking.networkmanager.enable = true;

    # security for passwords
    security.pam.services.login.kwallet.enable = true;
    security.pam.services.${vars.username}.kwallet.forceRun = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # allow phone to access ports for expo
    networking.firewall.allowedTCPPorts = [ 8080 8081 8082 ];
}
