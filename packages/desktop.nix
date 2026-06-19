# Desktop‑only packages (AMD + Nvidia machine)
pkgs: with pkgs; [
  firefox

  # Hyprland keybind dependencies (see modules/config-apps/hyprland)
  rofi-wayland
  hyprlock
  grim
  slurp
]
# Hyprland itself, waybar, etc. are enabled as programs in the system module
