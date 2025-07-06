{ config, pkgs, ... }:

let
  hyprlandConfigDir = "${config.home.homeDirectory}/.config/hypr";
in
{
  home.file."${hyprlandConfigDir}/hyprland.conf" = {
    text = ''

    source = ~/.cache/wal/colors-hyprland.conf
    
    monitor = DP-1,2560x1440@60,0x0,1
    monitor = HDMI-A-2,1920x1080@60,-1920x0,1
    monitor = HDMI-A-1,2732x2048@60,2560x0,2

    $terminal = kitty
    $browser = firefox
    $filemanager = kitty -e yazi
    $editor = code
    $launcher = wofi -n --show drun 
    $mainMod = SUPER
    
    exec-once = clipse -listen
    exec-once = quickshell
    exec-once = swww-daemon
    exec-once = mitmdump --listen-port=8889 -s ~/.config/proxy/geforce-interceptor.py &>/dev/null &
    exec-once = sunshine
    
    env = ELECTRON_OZONE_PLATFORM_HINT,wayland
    env = HYPRCURSOR_THEME,Furina-v2
    env = HYPRCURSOR_SIZE,12

    general {
        gaps_in = 2
        gaps_out = 10
        border_size = 0
        resize_on_border = true
        allow_tearing = false
        layout = dwindle
    }

    decoration {
        rounding = 5
            active_opacity = 0.78
            inactive_opacity = 0.70
            fullscreen_opacity = 1
            blur {
                enabled = true
                    size = 3
                    passes = 5
                    new_optimizations = true
                    ignore_opacity = true
                    xray = false
                    popups = true
            }
        shadow {
            enabled = true
                range = 15
                render_power = 5
                color = rgba(0,0,0,.5)
        }
    }

    animations {
        enabled = true
        bezier = fluid, 0.15, 0.85, 0.25, 1
        bezier = snappy, 0.3, 1, 0.4, 1
        animation = windows, 1, 3, fluid, popin 5%
        animation = windowsOut, 1, 2.5, snappy
        animation = fade, 1, 4, snappy
        animation = workspaces, 1, 1.7, snappy, slide
        animation = specialWorkspace, 1, 4, fluid, slidefadevert -35%
        animation = layers, 1, 2, snappy, popin 70%
    }

    misc { 
        force_default_wallpaper = -1
        disable_hyprland_logo = true
        focus_on_activate = true
    }

    input {
        kb_layout = us
            follow_mouse = 1
            sensitivity = 0
            touchpad {
                natural_scroll = true
            }
    }

    gestures {
        workspace_swipe = true
            workspace_swipe_distance = 300
            workspace_swipe_cancel_ratio = .05
            workspace_swipe_min_speed_to_force = 0
    }

    # BINDINGS
    bind = $mainMod, V, exec, $terminal --class clipse -e 'clipse'
    bind = $mainMod SHIFT, S, exec, hyprshot -m region --clipboard-only
    bind = $mainMod, T, exec, $terminal
    bind = $mainMod, Q, killactive
    bind = $mainMod, E, exec, $filemanager
    bind = $mainMod, W, exec, $browser
    bind = $mainMod, Tab, togglefloating
    bind = $mainMod, R, exec, $launcher
    bind = $mainMod, F, fullscreen
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10
    bind = $mainMod, S, togglespecialworkspace
    bind = $mainMod ALT, 1, movetoworkspace, 1
    bind = $mainMod ALT, 2, movetoworkspace, 2
    bind = $mainMod ALT, 3, movetoworkspace, 3
    bind = $mainMod ALT, 4, movetoworkspace, 4
    bind = $mainMod ALT, 5, movetoworkspace, 5
    bind = $mainMod ALT, 6, movetoworkspace, 6
    bind = $mainMod ALT, 7, movetoworkspace, 7
    bind = $mainMod ALT, 8, movetoworkspace, 8
    bind = $mainMod ALT, 9, movetoworkspace, 9
    bind = $mainMod ALT, 0, movetoworkspace, 10
    bind = $mainMod ALT, S, movetoworkspace, special
    bind = $mainMod, M , exec, wpctl set-mute @DEFAULT_SOURCE@ toggle

    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous

    bind = CTRL, Print, exec, hyprshot -m region -o ~/Screenshots/
    bind = , Print, exec, hyprshot -m window -o ~/Screenshots/
    bind = ALT, Print, exec, hyprshot -m active -m output -o ~/Screenshots/

    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    
    layerrule = noanim, selection
    layerrule = blur, wofi
    layerrule = blur, .quickshell
    layerrule = ignorezero, wofi
    layerrule = ignorealpha 0.5, wofi

    windowrulev2 = float,class:(clipse)
    windowrulev2 = size 622 652,class:(clipse)
    windowrule = stayfocused, class:(clipse)
    windowrule = stayfocused, class:(wofi)
    '';
  };
}
