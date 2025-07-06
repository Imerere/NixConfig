{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "cider" ''
      exec ${pkgs.appimage-run}/bin/appimage-run ${../../assets/Cider/cider.AppImage} "$@"
    '')
  ];

  xdg.desktopEntries.cider = {
    name = "Cider";
    comment = "A modern Apple Music client";
    exec = "${config.home.profileDirectory}/bin/cider";
    icon = ../../assets/Cider/icon.png; # Place cider.png here and add to .gitignore if needed
    type = "Application";
    terminal = false;
    categories = [ "AudioVideo" "Player" ];
  };
}
