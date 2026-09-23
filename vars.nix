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
  wallpaper = "$HOME/Pictures/walls/apocalypse/a_car_parked_in_a_dark_alley.jpg";

  # ------------------------------------------------------------------
  # Theme - single source of truth for kitty, waybar, dunst and rofi.
  # ------------------------------------------------------------------
  theme = {
    fonts = {
      mono = "Recursive Mono";              # terminal / UI
      nerd = "JetBrainsMono Nerd Font";     # glyph fallback for bar + notifications
      sizeTerminal     = 11;
      sizeBar          = 13;
      sizeNotification = 10;
      sizeMenu         = 12;
    };

    # One Dark. `rec` so the semantic names below can reuse the palette.
    colors = rec {
      background = "#141619";  # darker than stock One Dark (#282c34)
      surface    = "#282c34";  # inputs, secondary panels
      overlay    = "#3d4350";  # borders, separators
      selection  = "#3e4451";
      foreground = "#abb2bf";
      comment    = "#5c6370";  # dimmed text / placeholders
      cursor     = "#528bff";

      black   = "#282c34";
      red     = "#e06c75";
      green   = "#98c379";
      yellow  = "#e5c07b";
      blue    = "#61afef";
      magenta = "#c678dd";
      cyan    = "#56b6c2";
      white   = "#abb2bf";

      brightBlack   = "#5c6370";
      brightRed     = "#e06c75";
      brightGreen   = "#98c379";
      brightYellow  = "#e5c07b";
      brightBlue    = "#61afef";
      brightMagenta = "#c678dd";
      brightCyan    = "#56b6c2";
      brightWhite   = "#ffffff";

      # Semantic aliases - point these at any palette entry above.
      accent       = yellow;      # active workspace, kitty tab bar
      highlight    = blue;        # rofi selected entry
      onHighlight  = "#000000";   # text drawn on top of `highlight`
      alert        = red;         # critical notifications, muted audio
      border       = overlay;
    };

    # Two hex digits appended to a colour, e.g. rofi panel translucency.
    opacity = {
      panel = "F2";  # ~95%
      input = "FF";
      row   = "80";  # ~50%
    };
  };

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
