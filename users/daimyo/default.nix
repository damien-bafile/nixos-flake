{ config, lib, pkgs, ... }:

{
  # User account configuration
  users.users.daimyo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  # Home Manager configuration
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.daimyo = import ./home.nix;
}
