{input, pkgs, config, ...}:
{
    networking.hostName = "robertNix"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # security for passwords
    security.pam.services.login.enableKwallet = true;
    security.pam.services.robshan.kwallet.forceRun = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;
}
