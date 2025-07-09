{ config, lib, pkgs, ... }:

{
  home.username = "daimyo";
  home.homeDirectory = "/home/daimyo";
  home.stateVersion = "25.05";
  
  # Install packages
  home.packages = with pkgs; [
    # Development tools
    warp-terminal
    zed-editor
    gh        # GitHub CLI tool
    git       # Git version control
    lazygit   # Terminal UI for git
    
    # System utilities
    btop
    
    # Note: neovim and yazi are configured through programs below
  ];
  
  # Enable programs with configuration
  programs.home-manager.enable = true;
  
  # Basic neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  
  # Yazi configuration
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };
  
  # Git configuration
  programs.git = {
    enable = true;
    userName = "daimyo";
    userEmail = "your-email@example.com"; # Update this
  };
  
  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
