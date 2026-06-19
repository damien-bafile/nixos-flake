# Simple packages that need no extra configuration
pkgs: with pkgs; [
  # Core tools
  git
  curl
  wget
  htop
  tmux
  ripgrep
  fd
  jq
  tree

  # Apps without dotfile configs
  lazygit
  telegram-desktop
  bat
  lsd
  mpd
  gh
  opencode
]
