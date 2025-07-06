{ lib, stdenvNoCC, ... }:


stdenvNoCC.mkDerivation {
  pname = "Furina-v2";
  version = "1.0.0";

  src = ../../assets/Furina-v2;

  installPhase = ''
    mkdir -p $out/share/icons/Furina-v2
    cp -r . $out/share/icons/Furina-v2/

    if [ -f "$out/share/icons/Furina-v2/index.theme" ]; then
      sed -i '/^\[Icon Theme\]/a Size=32' "$out/share/icons/Furina-v2/index.theme"
    else
      cat > "$out/share/icons/Furina-v2/index.theme" << 'EOF'
[Icon Theme]
Name=Furina-v2
Comment=Furina v2 cursor theme
Inherits=Adwaita
Size=32
EOF
    fi
  '';

  meta = with lib; {
    description = "Furina-v2 cursor theme";
    platforms = platforms.all;
    license = licenses.unfree;
    maintainers = [ maintainers.Imerere ];
  };
}