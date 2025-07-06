{config, pkgs, inputs, ...}:

{
  environment.systemPackages = with pkgs; [
    # inputs.zaphkiel.packages.${system}.kurukurubar
    wget
    unzip
    git
    pavucontrol
    pulseaudio
    waypaper
    pywal16
    pywalfox-native
    arrpc
    swww
    swaybg
    adwaita-icon-theme
    gnome-themes-extra
    nodePackages.prettier
    xwayland
    ffmpeg
    mesa
    libva
    libva-utils
    playerctl
    libayatana-appindicator
    nh
    base16-schemes
    ddcutil
    brightnessctl
  ];
}
