{ vars, ... }:

{
    programs.ssh = {
        extraConfig = "
            Host ${vars.hostnames.server}
                Hostname ${vars.hostnames.server}
                Port ${toString vars.sshPort}
                User ${vars.serverUsername}
            ";
    };
}
