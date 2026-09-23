# Central configuration values.
#
# Everything user-tunable lives here so the rest of the tree stays generic.
# It is threaded into every NixOS and Home Manager module via specialArgs /
# extraSpecialArgs in flake.nix, so any module can access it as `vars`.
{
  # NixOS + Home Manager state version (system.stateVersion / home.stateVersion).
  # This records the release a machine was FIRST installed with so stateful data
  # keeps its old defaults. It is not a version to upgrade - bump the channels in
  # flake.nix `inputs` instead, and leave this alone.
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
  wallpaper = "$HOME/Pictures/walls/apocalypse/a_car_parked_in_a_dark_alley.jpg";

  # ------------------------------------------------------------------
  # Theme - single source of truth for kitty, waybar, dunst and rofi.
  # Swap the look by importing a different file from ./themes.
  # ------------------------------------------------------------------
  theme = import ./themes/one_dark.nix;

  # Login screen (SDDM greeter theme - see system/login/default.nix)
  login = {
    flavor      = "mocha";   # latte | frappe | macchiato | mocha
    font        = "JetBrainsMono Nerd Font";
    fontSize    = "12";
    cursorTheme = "Adwaita";
    # A nix path to an image (e.g. ./assets/login.jpg), or null for the
    # theme's own background. Must be a store path, not "$HOME/...".
    background  = null;
  };

  # Services / networking
  domain    = "robshan.space";         # base domain for nginx/jellyfin/nextcloud/headscale
  serverIp  = "192.168.15.217";        # server LAN IP (unbound local zone)
  acmeEmail = "robshanahan5@duck.com"; # ACME / Let's Encrypt contact
  sshPort   = 5432;                    # OpenSSH port (server sshd + ssh client alias)
}
