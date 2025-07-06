{ pkgs, ... }:

let
  ipadFirmware = pkgs.runCommand "ipad-edid-firmware" {} ''
    mkdir -p $out/lib/firmware
    cp ${../../assets/ipad.bin} $out/lib/firmware/ipad.bin
  '';
in
{
  hardware.firmware = [ ipadFirmware ];

  boot.kernelParams = [
    "drm.edid_firmware=HDMI-A-1:ipad.bin"
    "video=HDMI-A-1:e"
  ];
}