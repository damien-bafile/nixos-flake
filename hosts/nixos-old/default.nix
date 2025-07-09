{
  config,
  lib,
  pkgs,
  nixos-hardware,
  home-manager,
  ...
}:

{
  imports = [
    # Hardware configuration
    ../../hardware-configuration.nix
    nixos-hardware.nixosModules.framework-12th-gen-intel

    # System modules
    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/networking.nix
    ../../modules/system.nix

    # Home Manager
    home-manager.nixosModules.home-manager
    ../../users/daimyo
  ];

  # Host-specific settings
  networking.hostName = "nixos";
  time.timeZone = "Australia/Perth";

  system.stateVersion = "25.05";
}
