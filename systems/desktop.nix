{ pkgs, inputs, config, ... }:
{
  _module.args = { inherit inputs; };   # propagate `inputs` down to config-apps modules

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/config-apps   # auto‑imports neovim, ghostty, emacs
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # CachyOS kernel: BORE scheduler, zen4 microarch optimization.
  # 7800X3D is Zen 4 — using the dedicated zen4 variant (tighter-tuned than
  # generic x86_64-v3/v4) for the best fit.
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-zen4;
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  # ananicy-cpp: auto-renices foreground/heavy processes, deprioritizes background ones
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  # zram swap — compressed RAM-backed swap, reduces disk thrashing under memory pressure
  zramSwap.enable = true;

  # Nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Hyprland enabled + keybinds defined once in modules/config-apps/hyprland
  programs.steam.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # VirtualBox
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
  users.users.yourname.extraGroups = [ "vboxusers" ];   # ← CHANGE TO YOUR USERNAME

  # Ollama with Nvidia CUDA acceleration (systemd service, per NixOS wiki recommendation)
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    # Optional: preload models on first activation, e.g.
    # loadModels = [ "llama3.2:3b" ];
  };

  # CUDA support (global + toolkit + cuDNN)
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages =
    (import ../packages/common.nix pkgs)
    ++ (import ../packages/desktop.nix pkgs)
    ++ [
      pkgs.cudaPackages.cudatoolkit
      pkgs.cudaPackages.cudnn
    ];

  nixpkgs.config.allowUnfree = true;   # Nvidia, Steam, CUDA, VirtualBox ext pack

  # Home Manager for your user
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.yourname = {          # ← CHANGE TO YOUR USERNAME
      home.stateVersion = "26.05";
    };

    # Per-machine monitor config. Run `hyprctl monitors` once logged into
    # Hyprland to get the real output name (e.g. DP-1, HDMI-A-1) and resolution.
    # Format: "name, resolution@refresh, position, scale"
    sharedModules = [{
      wayland.windowManager.hyprland.settings.monitor = [
        # TODO: RESOLUTION HERE — e.g. "DP-1, 3440x1440@144, 0x0, 1"
      ];
    }];
  };
}
