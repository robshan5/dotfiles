{ vars, ... }:

{
    services.openssh = {
        enable = true;
        ports = [ vars.sshPort ];
    };
}
