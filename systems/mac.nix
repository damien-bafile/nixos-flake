{ pkgs, inputs, ... }:
{
  _module.args = { inherit inputs; };

  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../modules/config-apps
  ];

  system.stateVersion = 4;

  # System‑wide packages
  environment.systemPackages =
    (import ../packages/common.nix pkgs)
    ++ (import ../packages/mac.nix pkgs)
    ++ [ pkgs.ollama ];   # Ollama for Mac

  # Some macOS defaults
  system.defaults = {
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";
  };

  # Homebrew integration (optional)
  homebrew.enable = true;
  homebrew.casks = [ "firefox" ];   # or install via nixpkgs if you prefer

  # Home Manager for your user
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.yourname = {          # ← CHANGE TO YOUR USERNAME
      home.stateVersion = "26.05";
    };
  };
}
