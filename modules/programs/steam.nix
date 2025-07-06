{ pkgs, inputs, ... }:

{
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # OpenGL and Vulkan configuration
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-tools
  ];

  # Add system packages for VR support
  environment.systemPackages = with pkgs; [
    openvr # Required for SteamVR
    libusb1 # Used for VR devices
    usbutils
    pkgs.libsndfile
    pkgs.xwayland
    gamescope
  ];

  # Udev rules for VR devices
  services.udev.packages = with pkgs; [
    openvr
  ];
}
