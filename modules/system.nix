{ config, lib, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Auto upgrade
  system.autoUpgrade = {
    enable = false; # Set to true if you want automatic updates
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "09:00";
    randomizedDelay = "45min";
  };
  
  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  # Optimize nix store
  nix.settings.auto-optimise-store = true;
}
