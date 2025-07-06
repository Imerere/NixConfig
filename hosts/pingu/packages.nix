{pkgs, inputs, ...}:

with pkgs;
[
  # Cursor
  (callPackage ../../modules/desktop/cursor.nix { })

  # Applications
  protonplus
  lutris
  prismlauncher
  peazip
  file-roller
  vscode

  # TUI
  cava
  pokeget-rs
  btop
  clipse
  timg
  chafa

  # Desktop
  polybarFull
  hyprlock
  nwg-look
  walker

  # Development
  nodejs
  rustup
  gcc
  gh
  nixfmt-rfc-style
  nixpkgs-fmt
  black

  # Utilities
  p7zip
  mitmproxy
  jq
  socat
  tree
  libnotify
  nvd
  wl-clipboard
  pywalfox-native
  imagemagick
  amdvlk
  rar
  unzip
  droidcam
  gowall
  gruvbox-gtk-theme
  papirus-icon-theme
  grimblast
  gpu-screen-recorder
  mpv
  slop

  # Quickshell stuff
  inputs.quickshell.packages.${system}.default
  qt6Packages.qt5compat
  libsForQt5.qt5.qtgraphicaleffects
  kdePackages.qtbase
  kdePackages.qtdeclarative

  # Niri
  xwayland-satellite
  grim
  slurp
  wl-clipboard
]
