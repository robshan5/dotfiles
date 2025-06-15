{ inputs, pkgs, ... }:
let
    background = "#141619";
    foreground = "#abb2bf";
    foreground_alert = "#e06c75";
    frame = "#abb2bf";
in{
    services.dunst = {
        enable = true;
        settings = {
            global = {
                monitor = 0;
                follow = "mouse";
                # width = 200;
                # height = 50;
                offset = "(15, 30)";
                origin = "top-right";
                transparency = 10;
                frame_color = frame;
                corner_radius = 8;
                font = "JetBrainsMono Nerd Font 9";
                format = "<b>%s</b>\\n%b";
                alignment = "left";
                icon_position = "left";
                separator_height = 1;
                padding = 16;
                horizontal_padding = 16;
                separator_color = "frame";
                idle_threshold = 120;
                line_height = 0;
                markup = "full";
            };

            urgency_low = {
                background = background;
                foreground = foreground;
                frame_color = frame;
                timeout = 4;
            };

            urgency_normal = {
                background = background;
                foreground = foreground;
                frame_color = frame;
                timeout = 6;
            };

            urgency_critical = {
                background = background;
                foreground = foreground_alert;
                frame_color = frame;
                timeout = 10;
            };
        };
    };
}
