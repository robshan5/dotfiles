{ ... }:

{
    networking.hostName = "laptop"; # Define your hostname.

  #   networking.extraHosts = ''
  # 192.168.15.217 nextcloud.local
  # 192.168.15.217 collabora.local
  #   '';

    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
        ../../system/users/robshan.nix
        ../../system/wm/default.nix
        ../../system/audio/default.nix
    ];
}
