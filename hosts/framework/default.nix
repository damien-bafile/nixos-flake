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
    nixos-hardware.nixosModules.framework-12th-gen-intel

    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/networking.nix
    ../../modules/system.nix
    ../../modules/framework.nix

    home-manager.nixosModules.home-manager
    ../../users/daimyo
  ];

  networking.hostName = "framework";
  time.timeZone = "Australia/Perth";

  system.stateVersion = "25.05";
}
