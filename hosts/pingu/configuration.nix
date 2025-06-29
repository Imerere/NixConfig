# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "quiet"
    "nowatchdog"
  ];
  # Gnome Virtual Filesystem
  services.gvfs.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pingu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Hyprland Desktop Environment.
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Enable gamemode
  programs.gamemode.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [ pkgs.mesa ];
  # Enable fish
  programs.fish.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Polkit + Dbus
  security.polkit.enable= true;
  services.dbus.enable = true;

  # xdg-portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.imere = {
    isNormalUser = true;
    description = "Imere";
    extraGroups = [ "networkmanager" "wheel" "video" "render" ];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "imere" = import ./home.nix;
    };
  };

  # usbmuxd
  programs.droidcam.enable = true;
  services.usbmuxd.enable = true;
  programs.obs-studio = {
    enableVirtualCamera = true;
    enable = true;
  };

  # SUNSHINE REMOTE DESKTOP
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  # Add certificates
  security.pki.certificates = [(builtins.readFile config/certificates/mitmproxy-ca-cert.pem)];

  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.nix-ld.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    noto-fonts-emoji
    noto-fonts
    dejavu_fonts
    font-awesome
  ];
  fonts.fontconfig.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
  ];
  environment.systemPackages =  with pkgs; [
  (pkgs.callPackage ./config/sddm/sddm-astronaut.nix {
    theme = "hyprland_kath";
    themeConfig={
        General = {
        HeaderText ="Hi Imere!";
              FontSize="10.0";
            };
        };
      })
    inputs.quickshell.packages."x86_64-linux".default
    protontricks
    wine
    wine64
    brightnessctl
    libdbusmenu
    dbus
    libdbusmenu-gtk3
    gtk-layer-shell
    bottom
    imagemagick
    acpi
    bluez
    bluez-tools
    rustup
    playerctl
    ffmpeg
    rar
    p7zip
    starship
    wlogout
    gvfs
    libnotify
    gtk3
    gtk4
    cairo
    glib
    pango
    hyprlock
    hyprcursor
    hyprpolkitagent
    appimage-run
    pavucontrol
    git
    vim
    kitty
    wget
    wl-clipboard
    material-symbols
    (python3.withPackages (ps: with ps; [ 
      pygame
      pip
      pydbus
      pygobject3
    ]))
    python2
    python3
    swaynotificationcenter
    usbutils
    corectrl
    mesa-demos
    vulkan-tools
    nodejs_24
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  environment.variables = {
    GI_TYPELIB_PATH = "${pkgs.gtk4}/lib/girepository-1.0:${pkgs.gtk-layer-shell}/lib/girepository-1.0";
    LD_LIBRARY_PATH = "${pkgs.gtk4}/lib:${pkgs.gtk-layer-shell}/lib";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
