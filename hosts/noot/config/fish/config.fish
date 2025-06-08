if status is-interactive
    set fish_greeting
    alias cider "appimage-run ~/Music/cider-v3.0.2-linux-x64.AppImage"
    clear
    fastfetch
    starship init fish | source
end
