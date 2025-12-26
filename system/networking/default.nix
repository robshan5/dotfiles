{input, pkgs, config, ...}:
{

    # Enable networking
    networking.networkmanager.enable = true;

    # security for passwords
    security.pam.services.login.enableKwallet = true;
    security.pam.services.robshan.kwallet.forceRun = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # allow phone to access ports for expo
    networking.firewall.allowedTCPPorts = [ 8080 8081 8082 ];
}
