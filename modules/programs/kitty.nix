{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      # Wallust colors
      include ~/.cache/wal/kitty-colors.conf

      cursor_shape beam

      font_size 12

      map ctrl+c copy_to_clipboard
      map ctrl+v paste_from_clipboard
      map ctrl+shift+c send_text all \x03

      confirm_os_window_close 0
    '';
  };
}
