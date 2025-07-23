{ inputs, pkgs, ... }:
let
    super = "Mod4";
    alt = "Mod1";
    wallpaper = "$HOME/Pictures/walls/digital/a_city_in_the_rain.jpeg";
in
    {
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = [ ",preferred,auto,1" ];
            exec-once = [
                "waybar"
                "kwalletd6"
                "hyprpaper"
                "playerctld daemon"
                "xset b off"
                "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"
                "/usr/libexec/xdg-desktop-portal"
                "/usr/libexec/xdg-desktop-portal-wlr"
                "/usr/libexec/xdg-desktop-portal-gtk"
                "export XDG_CURRENT_DESKTOP=KDE"
                "nm-applet --indicator"
                "blueman"
                "flameshot"
                "playerctld daemon"
            ];
            input = {
                kb_layout = "gb";
                touchpad = {
                    natural_scroll = true;
                };
            };
            general = {
                gaps_in = 10;
                gaps_out = 10;
                border_size = 2;
                layout = "dwindle";
            };
            decoration = {
                rounding = 5;
            };
            animations = {
                enabled = true;
                animation = [
                    "windows,1,3,default"
                    "fade,1,3,default"
                    "workspaces,1,3,default"
                ];
            };
            windowrulev2 = [
                "float,class:^(pavucontrol)$"
                "workspace 1,class:^(firefox)$"
                "workspace 2,class:^(kitty)$"
                "workspace 3,class:^(obsidian)$"
                "workspace 4,class:^(spotify)$"
                "workspace 5,class:^(transmission-gtk)$"
            ];
            bind = [
                # program keybindings
                "${super}+SHIFT, RETURN, exec, firefox"
                "${super}, RETURN, exec, kitty"
                "${super}+CONTROL, RETURN, exec, obsidian"
                "${super}, s, exec, LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify"
                "${super}, t, exec, transmission-gtk"

                # launcher
                "${super}, d, exec, rofi -lines 12 -padding 18 -width 60 -location 0 -show drun 0 -sidebar-mode -columns 3"

                # kill window
                "${super}, c, killactive"

                # focus movement
                "${super}, h, movefocus, l"
                "${super}, j, movefocus, d"
                "${super}, k, movefocus, u"
                "${super}, l, movefocus, r"

                # move windows
                "${super}+SHIFT, h, movewindow, l"
                "${super}+SHIFT, j, movewindow, d"
                "${super}+SHIFT, k, movewindow, u"
                "${super}+SHIFT, l, movewindow, r"

                # workspace switching
                "${super}, 1, workspace, 1"
                "${super}, 2, workspace, 2"
                "${super}, 3, workspace, 3"
                "${super}, 4, workspace, 4"
                "${super}, 5, workspace, 5"
                "${super}, 6, workspace, 6"
                "${super}, 7, workspace, 7"
                "${super}, 8, workspace, 8"
                "${super}, 9, workspace, 9"
                "${super}, 0, workspace, 10"

                # move to workspace
                "${super}+SHIFT, 1, movetoworkspace, 1"
                "${super}+SHIFT, 2, movetoworkspace, 2"
                "${super}+SHIFT, 3, movetoworkspace, 3"
                "${super}+SHIFT, 4, movetoworkspace, 4"
                "${super}+SHIFT, 5, movetoworkspace, 5"
                "${super}+SHIFT, 6, movetoworkspace, 6"
                "${super}+SHIFT, 7, movetoworkspace, 7"
                "${super}+SHIFT, 8, movetoworkspace, 8"
                "${super}+SHIFT, 9, movetoworkspace, 9"
                "${super}+SHIFT, 0, movetoworkspace, 10"

                # fullscreen
                "${super}, f, fullscreen, 1"

                # layout toggle (hyprland equivalent is more manual)
                "${super}+SHIFT, s, togglefloating"

                # floating toggle
                "${super}, space, togglefloating"

                #resize window
                "${super}+${alt}, h, resizeactive, -10 0"
                "${super}+${alt}, j, resizeactive, 0 -10"
                "${super}+${alt}, k, resizeactive, 0 10"
                "${super}+${alt}, l, resizeactive, 10 0"

                # restart (no direct swaymsg equivalent)
                "${super}+SHIFT, r, exec, hyprctl reload"

                # media keys (need to be bound via evdev or input-remapper)
                ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2%"
                ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2%"
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
                ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioStop, exec, playerctl --all-players stop"
                ", XF86AudioPrev, exec, playerctl previous"
                ", XF86AudioNext, exec, playerctl next"
                # ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86Calculator, exec, hyprlock"
                ", Print, exec, hyprshot -m window"
                "${super}, Print, exec, hyprshot -m output"
                "${super}+SHIFT, Print, exec, hyprshot -m region"
            ];
        };
    };
    services.hyprpaper = {
        enable = true;
        settings = {
            ipc = "on";
            splash = false;
            preload = "${wallpaper}";
            wallpaper = ",${wallpaper}";
        };
    };
}
