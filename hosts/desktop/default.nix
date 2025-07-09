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
    ../../hardware-configuration.nix
    nixos-hardware.nixosModules.nvidia

    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/networking.nix
    ../../modules/system.nix
    ../../modules/nvidia.nix
    ../../modules/desktop-hardware.nix

    home-manager.nixosModules.home-manager
    ../../users/daimyo
  ];

  networking.hostName = "desktop";
  time.timeZone = "Australia/Perth";

  system.stateVersion = "25.05";
}
