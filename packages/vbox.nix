# VirtualBox guest VM‑only packages
pkgs: with pkgs; [
  # Guest tooling beyond what virtualisation.virtualbox.guest.enable already provides
  spice-vdagent   # harmless no-op under VirtualBox, but handy if you ever switch hypervisors

  # Light testing/inspection tools — keep this VM lean on purpose
  neofetch
  htop

  # Hyprland keybind dependencies (see modules/config-apps/hyprland)
  rofi-wayland
  hyprlock
  grim
  slurp
]
# Hyprland is enabled as a program in the system module, same as desktop/framework.
# Deliberately omits anything GPU/CUDA-heavy — this target is for testing
# dotfiles and module wiring, not for running real workloads.
