{ pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
  };
  home.file.".config/fastfetch/config.jsonc".text = ''
//   _____ _____ _____ _____ _____ _____ _____ _____ _____
//  |   __|  _  |   __|_   _|   __|   __|_   _|     |  |  |
//  |   __|     |__   | | | |   __|   __| | | |   --|     |
//  |__|  |__|__|_____| |_| |__|  |_____| |_| |_____|__|__|  NYARCH
//
//  by Bina


{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": { "type": "command-raw", "source": "pokeget random --hide-name" },
    "display": {
        "separator": " "
    },
    "modules": [
        "break",
        "break",
        "break",
        {
            "type": "title",
            "keyWidth": 10
        },
        {
            "type": "custom",
            "format": "~~~~~~~~~~~~~~~~~~~~~~~~~~",
        },
        {
            "type": "os",
            "key": "~ ",
            "keyColor": "34",  // = color4
        },
        {
            "type": "kernel",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "packages",
            "format": "{} ",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "shell",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "terminal",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "wm",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "uptime",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "media",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "player",
            "key": "~ ",
            "keyColor": "34",
        },
        {
            "type": "colors",
            "key": "        ",
            "symbol": "circle"
        },
        "break",
    ]
}
  '';
}
