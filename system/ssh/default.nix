{ ... }:

{
    services.openssh = {
        enable = true;
        ports = [ 5432 ];
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ "robshan" ];
        };
    };
}
