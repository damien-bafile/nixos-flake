# Framework 13 laptop‑only packages
pkgs: with pkgs; [
  firefox

  # Hyprland keybind dependencies (see modules/config-apps/hyprland)
  rofi-wayland
  hyprlock
  grim
  slurp
]
# TLP and powertop are enabled as services
