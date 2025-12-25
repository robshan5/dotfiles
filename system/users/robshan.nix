{input, pkgs, config, ...}:
{
    users.users.robshan = {
        isNormalUser = true;
        description = "robshan";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
        hashedPassword = "$6$KvyuhrjXFfqWNQ7c$kYd5XbsXvG.Bu0IUDRlUPmHovmgcjEaFAm0Vj0gkVwyW2QTAzjH6B3W3sZQbLqyq/BbyXRmJM.0ucobG1MaYZ0";
    };

    nix.settings = {
        trusted-users = [ "root" "robshan" ];
    }
    ;
}
