{ pkgs, vars, ... }:
{
    users.users.${vars.username} = {
        isNormalUser = true;
        description = vars.username;
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
        hashedPassword = "$6$KvyuhrjXFfqWNQ7c$kYd5XbsXvG.Bu0IUDRlUPmHovmgcjEaFAm0Vj0gkVwyW2QTAzjH6B3W3sZQbLqyq/BbyXRmJM.0ucobG1MaYZ0";
    };

    nix.settings = {
        trusted-users = [ "root" vars.username ];
    };
}
