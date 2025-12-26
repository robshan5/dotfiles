{ ... }:

{
    programs.ssh = {
        extraConfig = "
            Host nix_server
                Hostname nixos
                Port 5432
                User nix_server
            ";
    };
}
