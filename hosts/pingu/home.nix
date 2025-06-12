{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "imere";
  home.homeDirectory = "/home/imere";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config = {
    allowUnfree = true;
  };
  home.packages = with pkgs; [
    usbmuxd
    droidcam
    anydesk
    gamescope
    krita
    btop
    audacity
    parsec-bin
    inputs.zen-browser.packages."x86_64-linux".default
    mitmproxy
    ryujinx
    pipes
    materia-theme
    qogir-icon-theme
    pywal
    pywalfox-native
    prismlauncher
    bs-manager
    osu-lazer
    wofi
    swww
    clipse
    libresprite
    hyprshot
    mangohud
    alacritty
    chromium
    vscode
    vesktop
    betterdiscordctl
    nautilus
    cava
    fastfetch
    lutris
    protonup-qt
    waybar
    obs-studio
  ];

  xdg.desktopEntries = {
    cider = {
      name = "Cider";
      genericName = "music player";
      exec = "appimage-run /home/imere/Music/cider-v3.0.2-linux-x64.AppImage";
      terminal = false;
      categories = [ "Application" "Network" "Music" ];
    };
    wlx-overlay = {
      name = "wlx-overlay";
      genericName = "overlay";
      exec = "appimage-run /home/imere/Music/WlxOverlay-S-v25.4.2-x86_64.AppImage";
      terminal = false;
      categories = [ "Application" "Network" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".icons/Furina-v2" = {
      source = config/themes/Furina-v2;
      force = true;
    };

    ".config/hypr" = {
      source = config/hypr;
      force = true;
    };

    ".config/fish" = {
      source = config/fish;
      force = true;
    };

    ".config/starship.toml" = {
      source = config/starship.toml;
      force = true;
    };

    # Example for directly setting text
    # ".gradle/gradle.properties" = {
    #   text = ''
    #     org.gradle.console=verbose
    #     org.gradle.daemon.idletimeout=3600000
    #   '';
    #   force = true;
    # };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Furina-v2";
      size = 24;
    };
    theme = {
      name = "Materia-dark";
    };
    iconTheme = {
      name = "Qogir-Dark";
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Materia-dark
    gtk-icon-theme-name = Qogir-dark
    gtk-cursor-theme-name = Furina-v2
    gtk-font-name = Cantarell 11
  '';

  xresources.properties = {
    "Xcursor.theme" = "Furina-v2";
    "Xcursor.size" = "24";
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Furina-v2";
    XCURSOR_SIZE = "24";
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/imere/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "code";
    RADV_PERFTEST = "vr";
    BROWSER = "zen";
    GTK_USE_PORTAL = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
