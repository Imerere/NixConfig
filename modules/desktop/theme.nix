{ config, pkgs, ... }:

{

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Furina-v2";
      size = 32;
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
    "Xcursor.size" = "32";
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Furina-v2";
    XCURSOR_SIZE = "32";
  };

  home.file = {
    ".icons/Furina-v2" = {
      source = ../../assets/Furina-v2;
      force = true;
    };

    ".config/starship.toml" = {
      source = ../../assets/starship.toml;
      force = true;
    };
  };
}
