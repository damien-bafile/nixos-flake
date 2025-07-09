{ config, lib, pkgs, ... }:

{
  # Boot loader configuration for UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
