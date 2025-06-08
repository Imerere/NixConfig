if status is-interactive
    cat /home/imere/.cache/wal/sequences
    set fish_greeting
    alias cider "appimage-run ~/Music/cider-v3.0.2-linux-x64.AppImage"
    clear
    fastfetch
    starship init fish | source
    function fish_postexec --on-event fish_postexec
        cat ~/.cache/wal/sequences
    end
end
