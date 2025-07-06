{ pkgs, ... }:

{
  home.packages = with pkgs; [
    matugen
  ];

  home.file = {
    ".config/matugen/templates/".source = ./matugentemplates;
  };

  home.file.".config/matugen/config.toml".text = ''
    [config]

    [templates.quickshell]
    input_path = '~/.config/matugen/templates/quickshell-colors.qml'
    output_path = '~/.config/quickshell/Data/Colors.qml'
  '';
}