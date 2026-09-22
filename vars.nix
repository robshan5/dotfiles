# Central configuration values.
#
# Everything user-tunable lives here so the rest of the tree stays generic.
# It is threaded into every NixOS and Home Manager module via specialArgs /
# extraSpecialArgs in flake.nix, so any module can access it as `vars`.
{
  # NixOS + Home Manager state version (system.stateVersion / home.stateVersion).
  # NOTE: the release channels in flake.nix `inputs` must be bumped by hand to
  # match — flake input URLs cannot read this file.
  stateVersion = "25.05";

  # Accounts
  username       = "robshan";     # primary interactive user
  serverUsername = "nix_server";  # headless server account

  # Host names (networking.hostName per machine)
  hostnames = {
    desktop = "Balor";
    laptop  = "Lugh";
    server  = "Dullahan";
  };

  # Localisation
  timeZone           = "Europe/Dublin";
  locale             = "en_IE.UTF-8";
  keyboardLayout     = "ie";  # system X11 + console
  homeKeyboardLayout = "uk";  # Home Manager

  # Desktop
  wallpaper = "$HOME/Pictures/lwalpapers/wallpapers/b-229.jpg";

  # Services / networking
  domain    = "robshan.space";         # base domain for nginx/jellyfin/nextcloud/headscale
  serverIp  = "192.168.15.217";        # server LAN IP (unbound local zone)
  acmeEmail = "robshanahan5@duck.com"; # ACME / Let's Encrypt contact
  sshPort   = 5432;                    # OpenSSH port (server sshd + ssh client alias)
}
