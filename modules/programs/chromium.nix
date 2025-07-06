{ config, lib, pkgs, ... }:

let
  script = ../../assets/proxy/geforce-interceptor.py;
in
{
  home.file.".config/proxy/geforce-interceptor.py".source = script;

  programs.chromium = {
    enable = true;
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      "onnfghpihccifgojkpnnncpagjcdbjod" # Proxy Switcher and Manager
    ];
  };
}