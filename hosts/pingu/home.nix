{ config, pkgs, inputs, self, lib, ... }:

{
  imports = [
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/theme.nix

    ../../modules/colors/pywal.nix
    ../../modules/colors/matugen.nix

    ../../modules/programs/obs.nix
    ../../modules/programs/yazi.nix
    ../../modules/programs/wofi.nix
    # ../../modules/programs/cider.nix
    ../../modules/programs/vscode.nix
    ../../modules/programs/vesktop.nix
    ../../modules/programs/chromium.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/fastfetch.nix

    ../../modules/shell/zsh.nix
  ];

  home.username = "imere";
  home.homeDirectory = "/home/imere";
  home.stateVersion = "25.05";

  home.packages = import ./packages.nix { inherit pkgs; inherit inputs; };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  home.sessionVariables = {
    EDITOR = "code";
    VISUAL = "code";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    FILE = "yazi";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
