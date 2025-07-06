#!/usr/bin/env bash

set -e

imgpath="$1"

if [[ ! -f "$imgpath" ]]; then
  echo "Usage: set-wall <image-path>"
  exit 1
fi

pkill quickshell
swww img --transition-type wipe --transition-angle 25 --transition-step 60 "$imgpath"
wal -i "$imgpath" -n --cols16
matugen image "$imgpath"
cp ~/.cache/wal/system24-pywal.theme.css ~/.config/vesktop/themes/system24-pywal.theme.css
cp ~/.cache/wal/wofi-colors.css ~/.config/wofi/style.css
cp ~/.cache/wal/clipse-colors.json ~/.config/clipse/custom_theme.json
cp ~/.config/quickshell/Data/Colors.qml /etc/nixos/assets/kurukurubar/Data/Colors.qml
quickshell >/dev/null 2>&1 & disown