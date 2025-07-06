{ pkgs, inputs, config, ... }:

{
  home.file = {
    ".config/wal/templates/".source = ./pywaltemplates;
  };
}