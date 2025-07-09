{ config, lib, pkgs, ... }:

{
  # Set up NixOS with cosmic
  services.desktopManager.cosmic.enable = true;
  
  # Pick your login manager
  services.displayManager.cosmic-greeter.enable = true;
  # Alternative: services.xserver.displayManager.gdm.enable = true;

  # Enable flatpak for flathub support
  services.flatpak.enable = true;
  
  # Fix flatpak XDG integration
  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "/home/daimyo/.local/share/flatpak/exports/share"
    ];
  };
  
  # Add flatpak to system packages for better integration
  environment.systemPackages = with pkgs; [
    flatpak
  ];
}
