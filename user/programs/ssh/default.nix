{ ... }:

{
    programs.ssh = {
        extraConfig = "
            Host server
                Hostname server
                Port 5432
                User nix_server
            ";
    };
}
