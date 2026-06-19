# PLACEHOLDER — replace this file with the real hardware-configuration.nix
# generated inside your VirtualBox VM by running:
#
#   nixos-generate-config --root /mnt
#
# during installation. This stub exists only so `nix flake check` / evaluation
# doesn't fail on a missing import before you've created the VM.
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.initrd.availableKernelModules = [ "ahci" "sd_mod" ];
  boot.kernelModules = [ ];

  system.stateVersion = "26.05";
}
