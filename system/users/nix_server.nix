{input, pkgs, config, ...}:
{
    users.users.nix_server = {
        isNormalUser = true;
        description = "nix_server";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
        hashedPassword = "$6$zrquBkaxWMVyvhS9$oYINKl6gflM2duj0ceW2sFNTCKlYoVlkkt8itxiLaAhvpJ3bwqoCdwxL6m/7bYZUeHC5/fLmRR.069VGS6qUZ.";
    };

    nix.settings = {
        trusted-users = [ "root" "nix_server" ];
    }
    ;
}
