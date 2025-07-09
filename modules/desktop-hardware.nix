{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Desktop-specific optimizations
  
  # Set CPU governor to performance (since we're not on battery)
  powerManagement.cpuFreqGovernor = "performance";
  
  # Enable high-performance settings
  services.tlp.enable = false; # Disable TLP as it's for laptops
  
  # Enable gaming-related services
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  
  # Enable real-time audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # Desktop-specific packages
  environment.systemPackages = with pkgs; [
    # Performance monitoring
    htop
    btop
    nvtopPackages.nvidia
    
    # Gaming
    lutris
    wine
    winetricks
    
    # Audio
    pavucontrol
    qjackctl
    
    # Hardware tools
    lm_sensors
    smartmontools
    
    # Overclocking/monitoring (if needed)
    # corectrl  # This might not be available
  ];
  
  # Enable additional filesystems for gaming
  boot.supportedFilesystems = [ "ntfs" ];
  
  # Enable USB 3.0 support
  services.udev.extraRules = ''
    # USB 3.0 support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="*", ATTRS{idProduct}=="*", MODE="0664", GROUP="users"
  '';
  
  # Enable bluetooth for gaming controllers
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Enable Xbox controller support
  # hardware.xone.enable = true;  # Requires kernel module
  
  # Enable KVM for virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
