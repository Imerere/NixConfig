{ pkgs, ... }:

{
  programs.wofi = {
    enable = true;
  };

  home.file.".config/wofi/config".text = ''
    [config]
    allow_images=true
    width=500
    show=drun
    prompt=Search
    height=400
    term=kitty
    hide_scroll=true
    print_command=true
    insensitive=true
    columns=1
    no_actions=true
  '';
}