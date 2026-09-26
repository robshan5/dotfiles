{ config, lib, vars, ... }:
# Hyprland >= 0.55 (nixpkgs 26.05) is configured in Lua, and Home Manager 26.05
# generates hyprland.lua instead of hyprland.conf once home.stateVersion >= 26.05.
# Each `settings.<name>` entry below is rendered as an `hl.<name>(...)` call.
let
    inherit (lib.generators) mkLuaInline;

    super = "SUPER";
    alt = "ALT";

    # hl.bind(key, dispatcher, flags?)
    bind = key: dispatcher: { _args = [ key (mkLuaInline dispatcher) ]; };
    bindWith = flags: key: dispatcher: { _args = [ key (mkLuaInline dispatcher) flags ]; };

    # `locked` keeps media keys working while the session is locked
    mediaBind = bindWith { locked = true; repeating = true; };
    playerBind = bindWith { locked = true; };
    repeatBind = bindWith { repeating = true; };
    mouseBind = bindWith { mouse = true; };

    directions = { h = "left"; j = "down"; k = "up"; l = "right"; };

    focusBinds = lib.mapAttrsToList (
        key: dir: bind "${super} + ${key}" ''hl.dsp.focus({ direction = "${dir}" })''
    ) directions;

    moveBinds = lib.mapAttrsToList (
        key: dir: bind "${super} + SHIFT + ${key}" ''hl.dsp.window.move({ direction = "${dir}" })''
    ) directions;

    resizeBinds = lib.mapAttrsToList (
        key: delta:
        repeatBind "${super} + ${alt} + ${key}" "hl.dsp.window.resize({ ${delta}, relative = true })"
    ) { h = "x = -15, y = 0"; j = "x = 0, y = 15"; k = "x = 0, y = -15"; l = "x = 15, y = 0"; };

    workspaceBinds = lib.concatMap (
        ws:
        let
            key = toString (lib.mod ws 10);
        in [
            (bind "${super} + ${key}" "hl.dsp.focus({ workspace = ${toString ws} })")
            (bind "${super} + SHIFT + ${key}" "hl.dsp.window.move({ workspace = ${toString ws} })")
        ]
    ) (lib.range 1 10);

    # hyprpaper resolves `~` but not `$HOME`
    wallpaper = lib.replaceStrings [ "$HOME" ] [ config.home.homeDirectory ] vars.wallpaper;
in
    {
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = {
                output = "";
                mode = "preferred";
                position = "auto";
                scale = 1;
            };

            config = {
                # used for the error bar and built-in notifications
                misc.font_family = vars.theme.fonts.nerd;
                input = {
                    kb_layout = vars.homeKeyboardLayout;
                    touchpad.natural_scroll = true;
                };
                general = {
                    gaps_in = 10;
                    gaps_out = 10;
                    border_size = 2;
                    layout = "dwindle";
                };
                decoration.rounding = 5;
                animations.enabled = true;
            };

            animation = [
                { leaf = "windows"; enabled = true; speed = 3; bezier = "default"; }
                { leaf = "fade"; enabled = true; speed = 3; bezier = "default"; }
                { leaf = "workspaces"; enabled = true; speed = 3; bezier = "default"; }
            ];

            window_rule = [
                { match.class = "zen-beta"; workspace = "1"; }
                { match.class = "kitty"; workspace = "2"; }
                { match.class = "obsidian"; workspace = "3"; }
                # spotify reports "spotify" on wayland and "Spotify" on xwayland
                { match.class = "(?i)spotify"; workspace = "4"; }
                { match.class = "transmission-gtk"; workspace = "5"; }
            ];

            # hyprpaper and dunst are started by their own systemd user units
            on = {
                _args = [
                    "hyprland.start"
                    (mkLuaInline ''
                        function()
                          hl.exec_cmd("waybar")
                          hl.exec_cmd("kwalletd6")
                          hl.exec_cmd("playerctld daemon")
                          hl.exec_cmd("nm-applet --indicator")
                          hl.exec_cmd("blueman-applet")
                        end
                    '')
                ];
            };

            bind = [
                # programs
                (bind "${super} + SHIFT + RETURN" ''hl.dsp.exec_cmd("zen-beta")'')
                (bind "${super} + RETURN" ''hl.dsp.exec_cmd("kitty")'')
                (bind "${super} + CTRL + RETURN" ''hl.dsp.exec_cmd("obsidian")'')
                (bind "${super} + S" ''hl.dsp.exec_cmd("LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify")'')
                (bind "${super} + T" ''hl.dsp.exec_cmd("transmission-gtk")'')

                # launcher
                (bind "${super} + D" ''hl.dsp.exec_cmd("rofi -show drun")'')

                # window management
                (bind "${super} + C" "hl.dsp.window.close()")
                (bind "${super} + F" ''hl.dsp.window.fullscreen({ mode = "maximized" })'')
                (bind "${super} + SPACE" ''hl.dsp.window.float({ action = "toggle" })'')
                (bind "${super} + SHIFT + S" ''hl.dsp.window.float({ action = "toggle" })'')

                # session
                (bind "${super} + SHIFT + R" ''hl.dsp.exec_cmd("hyprctl reload")'')
                (bind "${super} + SHIFT + E" "hl.dsp.exit()")

                # move/resize with the mouse
                (mouseBind "${super} + mouse:272" "hl.dsp.window.drag()")
                (mouseBind "${super} + mouse:273" "hl.dsp.window.resize()")

                # lock screen and screenshots
                (bind "XF86Calculator" ''hl.dsp.exec_cmd("hyprlock")'')
                (bind "Print" ''hl.dsp.exec_cmd("hyprshot -m window")'')
                (bind "${super} + Print" ''hl.dsp.exec_cmd("hyprshot -m output")'')
                (bind "${super} + SHIFT + Print" ''hl.dsp.exec_cmd("hyprshot -m region")'')

                # media keys
                (mediaBind "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+")'')
                (mediaBind "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")'')
                (mediaBind "XF86AudioMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
                (mediaBind "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("brightnessctl set 5%+")'')
                (mediaBind "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("brightnessctl set 5%-")'')
                (playerBind "XF86AudioPlay" ''hl.dsp.exec_cmd("playerctl play-pause")'')
                (playerBind "XF86AudioStop" ''hl.dsp.exec_cmd("playerctl --all-players stop")'')
                (playerBind "XF86AudioPrev" ''hl.dsp.exec_cmd("playerctl previous")'')
                (playerBind "XF86AudioNext" ''hl.dsp.exec_cmd("playerctl next")'')
            ]
            ++ focusBinds
            ++ moveBinds
            ++ resizeBinds
            ++ workspaceBinds;
        };
    };
    services.hyprpaper = {
        enable = true;
        settings = {
            ipc = true;
            splash = false;
            # empty monitor = fallback for every output
            wallpaper = [
                { monitor = ""; path = wallpaper; }
            ];
        };
    };
}
