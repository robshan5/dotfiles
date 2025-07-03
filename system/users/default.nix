{input, pkgs, config, ...}:
{
    users.users.robshan = {
        isNormalUser = true;
        description = "robshan";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };

    nix.settings = {
        trusted-users = [ "root" "robshan" ];
    }
    ;
}
