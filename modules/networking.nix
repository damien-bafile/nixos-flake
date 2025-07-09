{ config, lib, pkgs, ... }:

{
  # Networking configuration
  networking.networkmanager.enable = true;
  
  # Enable networking
  networking.useDHCP = lib.mkDefault true;
  
  # Firewall configuration
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
