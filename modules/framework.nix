{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Framework-specific optimizations
  
  # Disable power-profiles-daemon to avoid conflicts
  services.power-profiles-daemon.enable = false;
  
  # Enable TLP for better battery life
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # Intel P-state performance
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      
      # Runtime PM for PCI(e) bus devices
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      
      # USB autosuspend
      USB_AUTOSUSPEND = 1;
      
      # WiFi power saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
    };
  };
  
  # Enable fwupd for firmware updates
  services.fwupd.enable = true;
  
  # Enable fingerprint reader (if available)
  services.fprintd.enable = true;
  
  # Enable thermald for thermal management
  services.thermald.enable = true;
  
  # Enable auto-cpufreq for better CPU frequency scaling
  services.auto-cpufreq.enable = true;
  
  # Framework-specific packages
  environment.systemPackages = with pkgs; [
    fw-ectool  # Framework EC tool
    powertop   # Power usage monitoring
    acpi       # ACPI utilities
  ];
  
  # Enable Intel graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  
  # Backlight control
  programs.light.enable = true;
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
