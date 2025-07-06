{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      tamasfe.even-better-toml
      jnoortheen.nix-ide
    ];
  };
}
