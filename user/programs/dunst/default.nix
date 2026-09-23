{ vars, ... }:
let
    c = vars.theme.colors;
    f = vars.theme.fonts;
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
                frame_color = c.border;
                corner_radius = 8;
                font = "${f.nerd} ${toString f.sizeNotification}";
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
                background = c.background;
                foreground = c.comment;
                frame_color = c.border;
                timeout = 4;
            };

            urgency_normal = {
                background = c.background;
                foreground = c.foreground;
                frame_color = c.border;
                timeout = 6;
            };

            urgency_critical = {
                background = c.background;
                foreground = c.alert;
                frame_color = c.alert;
                timeout = 10;
            };
        };
    };
}
