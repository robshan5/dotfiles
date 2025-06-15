{ inputs, pkgs, ... }:
let
  super = "Mod4";
  alt = "Mod1";
  wallpaper = "$HOME/Pictures/walls/unsorted/a_black_and_white_image_of_a_monster.png";
in 
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "$super";
      fonts = {
        names = [ "JetBrainsMono" ];
        size = 10.0;
      };
      floating.modifier = "${super}";
      keybindings = {
        #program keybindings
        "${super}+Shift+Return" = "workspace 1, exec firefox";
        "${super}+Return" = "workspace 2, exec kitty";
        "${super}+Control+Return" = "workspace 3, exec obsidian";
        "${super}+s" = "workspace 4, exec spotify";
        "${super}+${alt}+Return" = "workspace 5, exec kitty -e yazi";
        "${super}+t" = "workspace 6, exec transmission-gtk";
        #wifi
        "${super}+w" = "exec wifi";
        #music
        # "${super}" = "exec music";
        #screenshot
        "${super}+q" = "exec grim -g \"$(slurp)\" ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png";
        #rofi
        "${super}+d" = "exec rofi -lines 12 -padding 18 -width 60 -location 0 -show drun 0 -sidebar-mode -columns 3";
        #kill window
        "${super}+c" = "kill";
        #change focus
        "${super}+h" = "focus left";
        "${super}+j" = "focus down";
        "${super}+k" = "focus up";
        "${super}+l" = "focus right";
        #move focused window
        "${super}+Shift+h" = "move left";
        "${super}+Shift+j" = "move down";
        "${super}+Shift+k" = "move up";
        "${super}+Shift+l" = "move right";
        #resize focused window
        "${super}+${alt}+h" = "resize shrink width 5 px";
        "${super}+${alt}+j" = "resize shrink height 5 px";
        "${super}+${alt}+k" = "resize grow height 5px";
        "${super}+${alt}+l" = "resize grow width 5px";
        #horizonal and vertical splits
        "${super}+p" = "split h";
        "${super}+v" = "split v";
        #fullscreen
        "${super}+f" = "fullscreen toggle";
        #change container layout
        "${super}+Shift+s" = "layout toggle split";
        #toggle tiling/floating view
        "${super}+space" = "floating toggle";
        #change focus between tiling/floating
        "${super}+Shift+space" = "focus mode_toggle";
        #switch to workspace
        "${super}+Control+l" = "workspace next";
        "${super}+Control+h" = "workspace prev";
        "${super}+1" = "workspace 1";
        "${super}+2" = "workspace 2";
        "${super}+3" = "workspace 3";
        "${super}+4" = "workspace 4";
        "${super}+5" = "workspace 5";
        "${super}+6" = "workspace 6";
        "${super}+7" = "workspace 7";
        "${super}+8" = "workspace 8";
        "${super}+9" = "workspace 9";
        "${super}+0" = "workspace 10";
        #move focused container to workspace
        "${super}+Shift+1" = "move container to workspace 1";
        "${super}+Shift+2" = "move container to workspace 2";
        "${super}+Shift+3" = "move container to workspace 3";
        "${super}+Shift+4" = "move container to workspace 4";
        "${super}+Shift+5" = "move container to workspace 5";
        "${super}+Shift+6" = "move container to workspace 6";
        "${super}+Shift+7" = "move container to workspace 7";
        "${super}+Shift+8" = "move container to workspace 8";
        "${super}+Shift+9" = "move container to workspace 9";
        "${super}+Shift+0" = "move container to workspace 10";
        #move focused container to workspace and switch
        "${super}+Control+1" = "move container to workspace 1, workspace 1";
        "${super}+Control+2" = "move container to workspace 2, workspace 2";
        "${super}+Control+3" = "move container to workspace 3, workspace 3";
        "${super}+Control+4" = "move container to workspace 4, workspace 4";
        "${super}+Control+5" = "move container to workspace 5, workspace 5";
        "${super}+Control+6" = "move container to workspace 6, workspace 6";
        "${super}+Control+7" = "move container to workspace 7, workspace 7";
        "${super}+Control+8" = "move container to workspace 8, workspace 8";
        "${super}+Control+9" = "move container to workspace 9, workspace 9";
        "${super}+Control+0" = "move container to workspace 10, workspace 10";
        #restart sway in place
        "${super}+Shift+r" = "exec swaymsg reload";
        #media keybindings
        "XF86AudioRaiseVolume" = "exec --no-startup-id media-control volume_up";
        "XF86AudioLowerVolume" = "exec --no-startup-id media-control volume_down";
        "XF86AudioMute" = "exec --no-startup-id media-control volume_mute";
        "XF86MonBrightnessUp" = "exec --no-startup-id media-control brightness_up";
        "XF86MonBrightnessDown" = "exec --no-startup-id media-control brightness_down";
        # "XF86AudioPlayPause" = "exec --no-startup-id media-control play_pause";
        # "XF86AudioPause" = "exec --no-startup-id media-control play_pause";
        # "XF86AudioPlay" = "exec --no-startup-id media-control play_pause";
        # "XF86AudioNext" = "exec --no-startup-id media-control next_track";
        # "XF86AudioPrev" = "exec --no-startup-id media-control prev_track";
        "XF86AudioMicMute" = "exec --no-startup-id media-control mic_mute";
        "XF86Calculator" = "exec --no-startup-id betterlockscreen -l";
        "Print" = "exec --no-startup-id screenshot";
      };
      gaps = {
        inner = 10;
        outer = 10;
      };
      window.titlebar = false;
      colors.focused = {
        background = "#A89984";
        border = "#A89984";
        childBorder = "#A89984";
        indicator = "#A89984";
        text = "#A89984";
      };
      bars = [
        {
          command = "waybar";
          position = "top";
        }
      ];
      startup = [
        # {
        #   command = "exec --no-startup-id waybar";
        #   always = true;
        #   notification = false;
        # }
        {
          command = "exec swaybg -i ${wallpaper} -m fill";
          always = true;
        }
      ];
    };
    extraConfig = ''
      exec_always picom -b
      exec_always ollama serve
      exec_always playerctld daemon
      exec_always xset b off
      exec_always LD_PRELOAD=/usr/local/lib/spotify-adblock.so
      exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      exec /usr/libexec/xdg-desktop-portal &
      exec /usr/libexec/xdg-desktop-portal-wlr &
      exec /usr/libexec/xdg-desktop-portal-gtk &
      input * {
        xkb_layout gb
        tap enabled
        natural_scroll enabled
      }
    '';
  };
}
