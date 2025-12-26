{ ... }:

{
    services.openssh = {
        enable = true;
        ports = [ 5432 ];
    };
}
