# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, self, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/desktop/ipad-monitor.nix
      ../../modules/programs/steam.nix
      ../../modules/packages.nix
      ../../modules/fonts.nix
      ../../modules/xdg.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPatches = [
      {
        name = "amdgpu-ignore-ctx-privileges";
        patch = pkgs.fetchpatch {
          name = "cap_sys_nice_begone.patch";
          url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
          hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
        };
      }
    ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" "i2c-dev" ];
    initrd.availableKernelModules = [ "i2c-dev" ]; # ✅ Load early in initrd
    extraModprobeConfig = ''
      options v4l2loopback video_nr=0 card_label="DroidCam" exclusive_caps=1
    '';
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };

  networking = {
    hostName = "pingu";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
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
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };


  # Fix Home-Manager Clobbers
  system.userActivationScripts = {
    removeConflictingFiles = {
      text = ''
        rm -f /home/imere/.gtkrc-2.0.bak
      '';
    };
    restartProxyServer = {
      text = ''
        pkill mitmdump
        mitmdump --listen-port=8889 -s ~/.config/proxy/geforce-interceptor.py &>/dev/null &
      '';
    };
    quickshell = {
      text = ''
        rm -rf ~/.config/quickshell
        cp -r /etc/nixos/assets/kurukurubar ~/.config/quickshell
      '';
    };
  };

  # Enables the certificate to use mitmproxy for GeForce Now.
  security.pki.certificates = [(builtins.readFile ../../assets/proxy/mitmproxy-ca-cert.pem)];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "bak";
    users = {
      "imere" = import ./home.nix;
    };
  };

  services = {
    # Enable the KDE Plasma Desktop Environment.
    displayManager = {
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = "imere";
      };
    };

    dbus.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;

    # Configure keymap in X11
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager.sessionCommands = ''
        export XCURSOR_THEME="Furina-v2"
        export XCURSOR_SIZE="32"
      '';
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    '';

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  security.rtkit.enable = true;

  users.users.imere = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Imere";
    home = "/home/imere";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  # Install firefox.
  programs = {
    zsh.enable = true;
    firefox.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define the system state version.
  system.stateVersion = "25.05";
}
